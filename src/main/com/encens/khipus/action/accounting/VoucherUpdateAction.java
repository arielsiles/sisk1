package com.encens.khipus.action.accounting;

import com.encens.khipus.action.purchases.PurchaseDocumentAction;
import com.encens.khipus.framework.action.GenericAction;
import com.encens.khipus.framework.action.Outcome;
import com.encens.khipus.model.accounting.DocType;
import com.encens.khipus.model.finances.*;
import com.encens.khipus.model.purchases.PurchaseDocument;
import com.encens.khipus.service.accouting.VoucherAccoutingService;
import com.encens.khipus.service.finances.VoucherService;
import org.jboss.seam.ScopeType;
import org.jboss.seam.annotations.*;
import org.jboss.seam.international.StatusMessage;

import java.math.BigDecimal;
import java.util.ArrayList;
import java.util.List;

/**
 * @author
 * @version 3.0
 */
@Name("voucherUpdateAction")
@Scope(ScopeType.CONVERSATION)
public class VoucherUpdateAction extends GenericAction<Voucher> {

    public static String APPROVED_OUTCOME = "Approved";
    public static String ANNUL_OUTCOME = "Annul";

    CashAccount cashAccount = null;
    private BigDecimal debit;
    private BigDecimal credit;
    private String documentTypeCode = "";

    private DocType docType = new DocType();
    private Voucher voucher;
    private List<VoucherDetail> voucherDetails;

    private List<CashAccount> cashAccounts = new ArrayList<CashAccount>();

    private BigDecimal totalDebit = new BigDecimal("0.00");
    private BigDecimal totalCredit = new BigDecimal("0.00");

    @In
    private VoucherAccoutingService voucherAccoutingService;
    @In
    private VoucherService voucherService;
    @In(create = true)
    private PurchaseDocumentAction purchaseDocumentAction;

    @Factory(value = "voucherUpdate", scope = ScopeType.STATELESS)
    public Voucher initVoucher() {
        return getInstance();
    }

    @Override
    @Begin(ifOutcome = Outcome.SUCCESS, flushMode = FlushModeType.MANUAL)
    public String select(Voucher instance) {
        String outCome = super.select(instance);
        this.voucher = instance;
        this.docType = voucherService.getDocType(voucher.getDocumentType());
        setVoucherDetails(voucherAccoutingService.getVoucherDetailList(voucher));

        return outCome;
    }

    @Override
    @End
    public String update(){

        voucher.setDocumentType(docType.getName());
        voucher.setDetails(voucherDetails);
        BigDecimal totalD = new BigDecimal("0.00");
        BigDecimal totalC = new BigDecimal("0.00");

        try {
            for (VoucherDetail voucherDetail : voucherDetails) {
                totalD = totalD.add(voucherDetail.getDebit());
                totalC = totalC.add(voucherDetail.getCredit());
            }
            System.out.println("__ __ Total D: " + totalD);
            System.out.println("__ __ Total C: " + totalC);

            if(totalD.doubleValue() == 0.00 || totalC.doubleValue() == 0.00){
                facesMessages.addFromResourceBundle(StatusMessage.Severity.ERROR,"Voucher.message.incorrectAccountingEntry");
                return Outcome.REDISPLAY;
            }

            if(totalD.doubleValue() != totalC.doubleValue()){
                facesMessages.addFromResourceBundle(StatusMessage.Severity.ERROR,"Voucher.message.incorrectAccountingEntry");
                return Outcome.REDISPLAY;
            }

            voucherAccoutingService.updateVoucher(voucher);

            return Outcome.SUCCESS;

        } catch (Exception e) {
            return Outcome.FAIL;
        }
    }

    public String createPurchaseDocument() {
        return purchaseDocumentAction.createFromAccounting();
    }

    @End(beforeRedirect = true)
    public String approvePurchaseDocument() {
        return purchaseDocumentAction.approveFromAccounting();
    }

    public String approveVoucher(){

        voucher.setState(VoucherState.APR.toString());
        voucherAccoutingService.approveVoucher(voucher);
        facesMessages.addFromResourceBundle(StatusMessage.Severity.INFO,"Voucher.message.approveAccountingEntry");
        return APPROVED_OUTCOME;
    }

    public String annulVoucher(){

        voucher.setState(VoucherState.ANL.toString());
        voucherAccoutingService.annulVoucher(voucher);
        facesMessages.addFromResourceBundle(StatusMessage.Severity.INFO,"Voucher.message.annulAccountingEntry");
        return ANNUL_OUTCOME;
    }

    public void assignVoucherDetail(CashAccount cashAccount){
        VoucherDetail voucherDetail = new VoucherDetail();
        voucherDetail.setCashAccount(cashAccount);
        voucherDetail.setAccount(cashAccount.getAccountCode());
        voucherDetails.add(voucherDetail);
        System.out.println("... ... ... Add Voucher Detail: " + cashAccount.getFullName());
    }

    public void removeVoucherDetail(VoucherDetail voucherDetail) {
        System.out.println("---> " + voucherDetail.getCashAccount().getDescription() + " - " + voucherDetail.getDebit() + " - " + voucherDetail.getCredit());
        voucherDetails.remove(voucherDetail);
    }

    public boolean isApproved() {
        return VoucherState.APR.toString().equals(voucher.getState());
    }

    public boolean isPending() {
        return VoucherState.PEN.toString().equals(voucher.getState());
    }

    public void assignProvider(Provider provider) {
        getInstance().setProvider(provider);
        this.voucher.setProvider(provider);
    }

    /* todo */
    private void cleanMovementDetailFields() {

    }
    /* todo */
    public void cleanMainFields() {

        cleanMovementDetailFields();
    }

    public BigDecimal getTotalsDebit(){
        BigDecimal total = new BigDecimal("0.00");
        for (VoucherDetail voucherDetail : voucherDetails) {
            if(voucherDetail.getDebit() != null)
                total = total.add(voucherDetail.getDebit());
        }
        //System.out.println("_____getTotalsDebit::::" + total);
        return total;
    }

    public BigDecimal getTotalsCredit(){
        BigDecimal total = new BigDecimal("0.00");
        for (VoucherDetail voucherDetail : voucherDetails) {
            if(voucherDetail.getCredit() != null)
                total = total.add(voucherDetail.getCredit());
        }
        //System.out.println("_____getTotalsCredit:::: " + total);
        return total;
    }

    /**
     * For Purchase Document
     */
    @Begin(nested = true, flushMode = FlushModeType.MANUAL)
    public String addPurchaseDocument() {
        setOp(OP_CREATE);
        return purchaseDocumentAction.addPurchaseDocumentFromAccounting();
        //return Outcome.SUCCESS;
    }

    @Begin(nested = true, flushMode = FlushModeType.MANUAL)
    public String selectPurchaseDocument(PurchaseDocument purchaseDocument) {
        setOp(OP_UPDATE);
        return purchaseDocumentAction.select(purchaseDocument);
    }

    public List<CollectionDocumentType> getPurchaseDocumentTypeList() {

        List<CollectionDocumentType> collectionDocumentTypeList = new ArrayList<CollectionDocumentType>();
        collectionDocumentTypeList.add(CollectionDocumentType.INVOICE);

        return collectionDocumentTypeList;
    }

    public void assignFinancesEntity(FinancesEntity financesEntity) {
        purchaseDocumentAction.assignFinancesEntity(financesEntity);
    }

    /**
     * End Purchase Document
     */

    public List<CashAccount> getCashAccounts() {
        return cashAccounts;
    }

    public void setCashAccounts(List<CashAccount> cashAccounts) {
        this.cashAccounts = cashAccounts;
    }

    public BigDecimal getDebit() {
        return debit;
    }

    public void setDebit(BigDecimal debit) {
        this.debit = debit;
    }

    public BigDecimal getCredit() {
        return credit;
    }

    public void setCredit(BigDecimal credit) {
        this.credit = credit;
    }

    public String getDocumentTypeCode() {
        return documentTypeCode;
    }

    public void setDocumentTypeCode(String documentTypeCode) {
        this.documentTypeCode = documentTypeCode;
    }


    public Voucher getVoucher() {
        return voucher;
    }

    public void setVoucher(Voucher voucher) {
        this.voucher = voucher;
    }

    public VoucherAccoutingService getVoucherAccoutingService() {
        return voucherAccoutingService;
    }

    public void setVoucherAccoutingService(VoucherAccoutingService voucherAccoutingService) {
        this.voucherAccoutingService = voucherAccoutingService;
    }

    public List<VoucherDetail> getVoucherDetails() {
        return voucherDetails;
    }

    public void setVoucherDetails(List<VoucherDetail> voucherDetails) {
        this.voucherDetails = voucherDetails;
    }

    public DocType getDocType() {
        return docType;
    }

    public void setDocType(DocType docType) {
        this.docType = docType;
    }

    public BigDecimal getTotalDebit() {
        return totalDebit;
    }

    public void setTotalDebit(BigDecimal totalDebit) {
        this.totalDebit = totalDebit;
    }

    public BigDecimal getTotalCredit() {
        return totalCredit;
    }

    public void setTotalCredit(BigDecimal totalCredit) {
        this.totalCredit = totalCredit;
    }
}
