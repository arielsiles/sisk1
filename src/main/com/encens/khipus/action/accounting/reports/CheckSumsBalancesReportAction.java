package com.encens.khipus.action.accounting.reports;

import com.encens.khipus.action.accounting.VoucherUpdateAction;
import com.encens.khipus.action.reports.GenericReportAction;
import com.encens.khipus.action.reports.PageFormat;
import com.encens.khipus.action.reports.PageOrientation;
import com.encens.khipus.action.reports.ReportFormat;
import com.encens.khipus.service.accouting.VoucherAccoutingService;
import com.encens.khipus.service.finances.VoucherService;
import org.jboss.seam.ScopeType;
import org.jboss.seam.annotations.Create;
import org.jboss.seam.annotations.In;
import org.jboss.seam.annotations.Name;
import org.jboss.seam.annotations.Scope;

import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;

/**
 * Encens S.R.L.
 * This class implements the valued warehouse residue report action
 *
 * @author
 * @version 2.3
 */

@Name("checkSumsBalancesReportAction")
@Scope(ScopeType.PAGE)
public class CheckSumsBalancesReportAction extends GenericReportAction {

    private Date startDate;
    private Date endDate;

    //private CashAccount cashAccount;

    @In(create = true)
    VoucherUpdateAction voucherUpdateAction;
    @In
    private VoucherService voucherService;
    @In
    private VoucherAccoutingService voucherAccoutingService;


    @Create
    public void init() {
        restrictions = new String[]{
                //"voucherDetail.account=#{majorAccountingReportAction.cashAccount.accountCode}"
        };
        //sortProperty = "date";
    }

    @Override
    protected String getEjbql() {

        DateFormat df = new SimpleDateFormat("yyyy-MM-dd");
        String start = df.format(startDate);
        String end   = df.format(endDate);

        return  " SELECT " +
                "        voucherDetail.account as account, " +
                "        cashAccount.description as description, " +
                "        SUM(voucherDetail.debit) as totalDebit, " +
                "        SUM(voucherDetail.credit) as totalCredit " +
                "  FROM  VoucherDetail voucherDetail " +
                "  LEFT  JOIN voucherDetail.voucher voucher " +
                "  LEFT  JOIN voucherDetail.cashAccount cashAccount " +
                "  WHERE voucher.date between '"+start+"' and '"+end+"' " +
                "  group by voucherDetail.account, cashAccount.description ";

        /*return  " SELECT " +
                "        voucherDetail.account as account, " +
                "        cashAccount.description as description, " +
                "        SUM(voucherDetail.debit) as totalDebit, " +
                "        SUM(voucherDetail.credit) as totalCredit " +
                "  FROM  Voucher voucher " +
                "  LEFT  JOIN voucher.voucherDetailList voucherDetail " +
                "  LEFT  JOIN voucherDetail.cashAccount cashAccount " +
                "  WHERE voucher.date between '"+start+"' and '"+end+"' " +
                "  group by voucherDetail.account, cashAccount.description ";*/

    }

    public void generateReport() {

        String documentTitle = "COMPROBACIÓN DE SUMAS Y SALDOS";
        //String cashAccountName = this.cashAccount.getFullName();

        //Double balance = voucherAccoutingService.getBalance(startDate, cashAccount.getAccountCode());

        log.debug("Generating products produced report...................");
        HashMap<String, Object> reportParameters = new HashMap<String, Object>();

        reportParameters.put("documentTitle", documentTitle);
        reportParameters.put("startDate",startDate);
        reportParameters.put("endDate",endDate);
        //reportParameters.put("cashAccount",cashAccountName);
        //reportParameters.put("balance",balance);

        setReportFormat(ReportFormat.PDF);
        super.generateReport(
                "majorAccountingReport",
                "/accounting/reports/checkSumsBalancesReport.jrxml",
                PageFormat.LETTER,
                PageOrientation.PORTRAIT,
                messages.get("accounting.checkSumsBalance.TitleReport"),
                reportParameters);
    }

    /*public void clearAccount() {
        setCashAccount(null);
    }*/

    public Date getStartDate() {
        return startDate;
    }

    public void setStartDate(Date startDate) {
        this.startDate = startDate;
    }

    public Date getEndDate() {
        return endDate;
    }

    public void setEndDate(Date endDate) {
        this.endDate = endDate;
    }

    /*public CashAccount getCashAccount() {
        return cashAccount;
    }*/

    /*public void setCashAccount(CashAccount cashAccount) {
        this.cashAccount = cashAccount;
    }*/
}
