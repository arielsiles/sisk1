package com.encens.khipus.action.fixedassets;

import com.encens.khipus.action.reports.GenericReportAction;
import com.encens.khipus.action.reports.PageFormat;
import com.encens.khipus.action.reports.PageOrientation;
import com.encens.khipus.model.fixedassets.FixedAssetGroup;
import com.encens.khipus.model.fixedassets.FixedAssetSubGroup;
import com.encens.khipus.util.DateUtils;
import com.encens.khipus.util.MessageUtils;
import org.jboss.seam.ScopeType;
import org.jboss.seam.annotations.Create;
import org.jboss.seam.annotations.Name;
import org.jboss.seam.annotations.Scope;
import org.jboss.seam.annotations.security.Restrict;

import java.util.Date;
import java.util.HashMap;

/**
 * Encens S.R.L.
 * This class implements the fixed asset evolution by sub group summary report action
 *
 * @author
 * @version 2.25
 */

@Name("evolutionByFixedAssetSummaryReportAction")
@Scope(ScopeType.PAGE)
@Restrict("#{s:hasPermission('FIXEDASSETEVOLUTIONSUMMARYREPORT','VIEW')}")
public class EvolutionByFixedAssetSummaryReportAction extends GenericReportAction {
    private Date initDateRange;
    private Date endDateRange;
    private FixedAssetGroup fixedAssetGroup;
    private FixedAssetSubGroup fixedAssetSubGroup;
    private Long fixedAssetCode;
    private String barCode;

    @Create
    public void init() {
        restrictions = new String[]{
                "fixedAssetGroup=#{evolutionByFixedAssetSummaryReportAction.fixedAssetGroup}",
                "fixedAssetSubGroup=#{evolutionByFixedAssetSummaryReportAction.fixedAssetSubGroup}",
                "fixedAsset.fixedAssetCode=#{evolutionByFixedAssetSummaryReportAction.fixedAssetCode}",
                "lower(fixedAsset.barCode) like concat('%',concat(lower(#{evolutionByFixedAssetSummaryReportAction.barCode}),'%'))",
        };
        sortProperty = "fixedAssetGroup.description, fixedAssetGroup.id, fixedAssetSubGroup.description, fixedAssetSubGroup.id, fixedAsset.description, fixedAsset.fixedAssetCode, fixedAsset.id";
        groupByProperty = "fixedAssetGroup.description, fixedAssetGroup.id, fixedAssetSubGroup.description, fixedAssetSubGroup.id, fixedAsset.description, fixedAsset.fixedAssetCode, fixedAsset.id";
    }

    @Override
    protected String getEjbql() {
        return "SELECT fixedAssetGroup.id, " +
                "      fixedAssetGroup.description, " +
                "      fixedAssetSubGroup.id, " +
                "      fixedAssetSubGroup.description, " +
                "      fixedAsset.id, " +
                "      fixedAsset.barCode, " +
                "      fixedAsset.description " +
                "FROM  FixedAsset fixedAsset " +
                "      LEFT JOIN fixedAsset.fixedAssetSubGroup fixedAssetSubGroup " +
                "      LEFT JOIN fixedAssetSubGroup.fixedAssetGroup fixedAssetGroup ";

    }

    public void generateReport() {
        log.debug("generating fixedAssetEvolutionSummary......................................");

        String dateRange = "";
        dateRange += (initDateRange != null) ? MessageUtils.getMessage("DepreciationsSummaryReport.report.from",
                DateUtils.format(initDateRange, MessageUtils.getMessage("patterns.date"))) + " " : "";
        dateRange += (endDateRange != null) ? MessageUtils.getMessage("DepreciationsSummaryReport.report.to",
                DateUtils.format(endDateRange, MessageUtils.getMessage("patterns.date"))) : "";

        HashMap<String, Object> reportParameters = new HashMap<String, Object>();
        reportParameters.put("dateRangeParam", dateRange);
        super.generateReport(
                "fixedAssetEvolutionSummary",
                "/fixedassets/reports/evolutionByFixedAssetSummaryReport.jrxml",
                PageFormat.LETTER,
                PageOrientation.LANDSCAPE,
                messages.get("FixedAssetEvolutionSummary.report.title"),
                reportParameters);
    }

    public Date getInitDateRange() {
        return initDateRange;
    }

    public void setInitDateRange(Date initDateRange) {
        this.initDateRange = initDateRange;
    }

    public Date getEndDateRange() {
        return endDateRange;
    }

    public void setEndDateRange(Date endDateRange) {
        this.endDateRange = endDateRange;
    }

    public FixedAssetGroup getFixedAssetGroup() {
        return fixedAssetGroup;
    }

    public void setFixedAssetGroup(FixedAssetGroup fixedAssetGroup) {
        if (null != fixedAssetGroup) {
            this.fixedAssetGroup = getEntityManager().find(FixedAssetGroup.class, fixedAssetGroup.getId());
            fixedAssetSubGroup = null;
        } else {
            this.fixedAssetGroup = null;
        }
    }

    public FixedAssetSubGroup getFixedAssetSubGroup() {
        return fixedAssetSubGroup;
    }

    public void setFixedAssetSubGroup(FixedAssetSubGroup fixedAssetSubGroup) {
        if (fixedAssetSubGroup != null) {
            this.fixedAssetSubGroup = getEntityManager().find(FixedAssetSubGroup.class, fixedAssetSubGroup.getId());
            this.fixedAssetGroup = getEntityManager().find(FixedAssetGroup.class, this.fixedAssetSubGroup.getFixedAssetGroup().getId());
        } else {
            this.fixedAssetSubGroup = null;
        }
    }

    public void clearFixedAssetGroup() {
        setFixedAssetGroup(null);
        fixedAssetSubGroup = null;
    }

    public void clearFixedAssetSubGroup() {
        setFixedAssetSubGroup(null);
    }

    public Long getFixedAssetCode() {
        return fixedAssetCode;
    }

    public void setFixedAssetCode(Long fixedAssetCode) {
        this.fixedAssetCode = fixedAssetCode;
    }

    public String getBarCode() {
        return barCode;
    }

    public void setBarCode(String barCode) {
        this.barCode = barCode;
    }
}
