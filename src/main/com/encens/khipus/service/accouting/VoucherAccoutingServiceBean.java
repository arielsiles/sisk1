package com.encens.khipus.service.accouting;

import com.encens.khipus.framework.service.GenericServiceBean;
import com.encens.khipus.model.finances.Voucher;
import com.encens.khipus.model.finances.VoucherDetail;
import com.encens.khipus.service.finances.FinancesPkGeneratorService;
import org.jboss.seam.annotations.AutoCreate;
import org.jboss.seam.annotations.In;
import org.jboss.seam.annotations.Name;

import javax.ejb.Stateless;
import javax.ejb.TransactionAttribute;
import javax.persistence.EntityManager;
import javax.persistence.NoResultException;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import static javax.ejb.TransactionAttributeType.REQUIRES_NEW;

/**
 * @author
 * @version 2.4
 */
@Stateless
@Name("voucherAccoutingService")
@AutoCreate
public class VoucherAccoutingServiceBean extends GenericServiceBean implements VoucherAccoutingService {

    @In(value = "#{entityManager}")
    private EntityManager em;

    @In
    private FinancesPkGeneratorService financesPkGeneratorService;


    public void saveVoucher(Voucher voucher){

        voucher.setId(financesPkGeneratorService.newId_sf_tmpenc());

        if (voucher.getTransactionNumber() == null){
            voucher.setTransactionNumber(financesPkGeneratorService.getNextNoTransTmpenc());
        }

        if (voucher.getDocumentNumber() == null){
            voucher.setDocumentNumber(financesPkGeneratorService.getNextNoTransByDocumentType(voucher.getDocumentType()));
        }

        System.out.println("-------- VOUCHER ENCABEZADO -------");
        System.out.println("ID: " + voucher.getId());
        System.out.println("Fecha: " + voucher.getDate());
        System.out.println("NoTrans: " + voucher.getTransactionNumber());
        System.out.println("Tipo Doc: " + voucher.getDocumentType());
        System.out.println("Descripcion: " + voucher.getDescription());
        System.out.println("Glosa: " + voucher.getGloss());

        em.persist(voucher);
        em.flush();

        System.out.println("-------- VOUCHER DETAILS -------");
        for (VoucherDetail voucherDetail : voucher.getDetails()) {
            voucherDetail.setId(financesPkGeneratorService.newId_sf_tmpdet());
            voucherDetail.setTransactionNumber(voucher.getTransactionNumber());
            voucherDetail.setVoucher(voucher);

            System.out.println("CUENTA: " + voucherDetail.getAccount() + " NOTRANS:" + voucherDetail.getTransactionNumber() + " D:" + voucherDetail.getDebit() + " H:" + voucherDetail.getCredit());

            em.persist(voucherDetail);
            em.flush();
        }
    }

    @Override
    @TransactionAttribute(REQUIRES_NEW)
    public void updateVoucher(Voucher voucher) {

        List<VoucherDetail> voucherDetailsDB = getVoucherDetailList(voucher);
        for (VoucherDetail voucherDetail : voucherDetailsDB) {
            em.merge(voucherDetail);
            em.remove(voucherDetail);
            em.flush();
        }

        for (VoucherDetail voucherDetail : voucher.getDetails()) {
            if(voucherDetail.getTransactionNumber() == null){
                voucherDetail.setId(financesPkGeneratorService.newId_sf_tmpdet());
                voucherDetail.setTransactionNumber(voucher.getTransactionNumber());
                voucherDetail.setVoucher(voucher);

                em.persist(voucherDetail);
                em.merge(voucher);
                em.flush();

            }else{
                em.merge(voucherDetail);
                em.merge(voucher);
                em.flush();
            }
        }

        em.merge(voucher);
        em.flush();
    }

    @Override
    public void approveVoucher(Voucher voucher){
        em.merge(voucher);
        em.flush();
    }

    @Override
    public void annulVoucher(Voucher voucher){
        em.merge(voucher);
        em.flush();
    }

    @Override
    public List<VoucherDetail> getVoucherDetailList(String transactionNumber){

        List<VoucherDetail> voucherDetails = new ArrayList<VoucherDetail>();

        try {
            voucherDetails = (List<VoucherDetail>) em.createQuery("select voucherDetail from VoucherDetail voucherDetail " +
                    " where voucherDetail.transactionNumber = :transactionNumber ")
                    .setParameter("transactionNumber", transactionNumber)
                    .getResultList();
            /*voucherDetails = (List<VoucherDetail>) em.createNativeQuery("select * from sf_tmpdet where no_trans = :transactionNumber")
                    .setParameter("transactionNumber", transactionNumber).getResultList();*/
        }catch (NoResultException e){
            return null;
        }
        return voucherDetails;
    }

    @Override
    public List<VoucherDetail> getVoucherDetailList(Voucher voucher){

        List<VoucherDetail> voucherDetails = new ArrayList<VoucherDetail>();

        try {
            voucherDetails = (List<VoucherDetail>) em.createQuery("select voucherDetail from VoucherDetail voucherDetail " +
                    " where voucherDetail.voucher = :voucher ")
                    .setParameter("voucher", voucher)
                    .getResultList();
            /*voucherDetails = (List<VoucherDetail>) em.createNativeQuery("select * from sf_tmpdet where no_trans = :transactionNumber")
                    .setParameter("transactionNumber", transactionNumber).getResultList();*/
        }catch (NoResultException e){
            return null;
        }
        return voucherDetails;
    }

    @Override
    public Voucher getVoucher(String transactionNumber) {

        Voucher voucher = null;
        try {
            voucher = (Voucher) em.createQuery("select voucher from Voucher voucher " +
                    " where voucher.transactionNumber = :transactionNumber ")
                    .setParameter("transactionNumber", transactionNumber)
                    .getSingleResult();
        }catch (NoResultException e){
            return null;
        }
        return voucher;
    }

    public Voucher getVoucher(Long id) {

        Voucher voucher = null;
        try {
            voucher = (Voucher) em.createQuery("select voucher from Voucher voucher " +
                    " where voucher.id = :id ")
                    .setParameter("id", id)
                    .getSingleResult();
        }catch (NoResultException e){
            return null;
        }
        return voucher;
    }

    public Double getBalance(Date startDate, String cashAccountCode){

        //List<Voucher> voucherList = new ArrayList<Voucher>();
        List<VoucherDetail> voucherDetailList = new ArrayList<VoucherDetail>();

        try {
            /*voucherList = em.createQuery("select voucher from Voucher voucher " +
                            " left join voucher.voucherDetailList voucherDetail " +
                            " where voucher.date < :startdate " +
                            " and voucherDetail.account = :cashAccountCode ")
                    .setParameter("startdate", startDate)
                    .setParameter("cashAccountCode", cashAccountCode)
                    .getResultList();*/
            voucherDetailList = em.createQuery("select voucherDetail from VoucherDetail voucherDetail " +
                    " left join voucherDetail.voucher voucher " +
                    " where voucher.date < :startdate " +
                    " and voucherDetail.account = :cashAccountCode ")
                    .setParameter("startdate", startDate)
                    .setParameter("cashAccountCode", cashAccountCode)
                    .getResultList();
        }catch (NoResultException e){
            return null;
        }

        Double balance = new Double("0.00");
        Double balanceD = new Double("0.00");
        Double balanceC = new Double("0.00");

        System.out.println("-------- GET BALANCE ---------");
        /*for (Voucher voucher : voucherList){
            System.out.println("Voucher: " + voucher.getDocumentType() + " - " + voucher.getDocumentNumber());
            for (VoucherDetail voucherDetail : voucher.getVoucherDetailList()){
                System.out.println("VoucherDetail: " + voucherDetail.getCashAccount().getFullName() + " - " + voucherDetail.getDebit() + " - " + voucherDetail.getCredit());
                balance = balance + voucherDetail.getDebit().doubleValue();
            }
            System.out.println("--");
        }*/

        for (VoucherDetail voucherDetail : voucherDetailList){
            System.out.println("Voucher: " + voucherDetail.getVoucher().getDocumentType() + " - " + voucherDetail.getVoucher().getDocumentNumber());
            System.out.println("VoucherDetail: " + voucherDetail.getCashAccount().getFullName() + " - " + voucherDetail.getDebit() + " - " + voucherDetail.getCredit());
            System.out.println("--");

            balanceD = balanceD + voucherDetail.getDebit().doubleValue();
            balanceC = balanceC + voucherDetail.getCredit().doubleValue();
        }

        balance = (balanceD - balanceC);
        System.out.println("TOTAL BALANCE: " + balance);

        return balance;
    }

    public Double getBalanceProvider(Date startDate, String cashAccountCode, String providerCode){

        List<VoucherDetail> voucherDetailList = new ArrayList<VoucherDetail>();

        try {
            voucherDetailList = em.createQuery("select voucherDetail from VoucherDetail voucherDetail " +
                    " left join voucherDetail.voucher voucher " +
                    " where voucher.date < :startdate " +
                    " and voucherDetail.account = :cashAccountCode " +
                    " and voucher.providerCode = :providerCode " +
                    " and voucher.state <> 'ANL'")
                    .setParameter("startdate", startDate)
                    .setParameter("cashAccountCode", cashAccountCode)
                    .setParameter("providerCode", providerCode)
                    .getResultList();
        }catch (NoResultException e){
            return null;
        }

        Double balance = new Double("0.00");
        Double balanceD = new Double("0.00");
        Double balanceC = new Double("0.00");

        System.out.println("-------- GET BALANCE ---------");
        for (VoucherDetail voucherDetail : voucherDetailList){
            System.out.println("Voucher: " + voucherDetail.getVoucher().getDocumentType() + " - " + voucherDetail.getVoucher().getDocumentNumber());
            System.out.println("VoucherDetail: " + voucherDetail.getCashAccount().getFullName() + " - " + voucherDetail.getDebit() + " - " + voucherDetail.getCredit());
            System.out.println("--");

            balanceD = balanceD + voucherDetail.getDebit().doubleValue();
            balanceC = balanceC + voucherDetail.getCredit().doubleValue();
        }

        balance = (balanceD - balanceC);
        System.out.println("TOTAL BALANCE: " + balance);

        return balance;
    }
}
