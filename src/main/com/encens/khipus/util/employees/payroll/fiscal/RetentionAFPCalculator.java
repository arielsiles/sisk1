package com.encens.khipus.util.employees.payroll.fiscal;

import com.encens.khipus.model.employees.CategoryFiscalPayroll;
import com.encens.khipus.model.employees.CategoryTributaryPayroll;
import com.encens.khipus.util.employees.payroll.structure.Calculator;

/**
 * @author
 * @version 2.26
 */
public class RetentionAFPCalculator extends Calculator<CategoryFiscalPayroll> {

    private CategoryTributaryPayroll categoryTributaryPayroll;

    public RetentionAFPCalculator(CategoryTributaryPayroll categoryTributaryPayroll) {
        this.categoryTributaryPayroll = categoryTributaryPayroll;
    }

    @Override
    public void execute(CategoryFiscalPayroll instance) {
        instance.setRetentionAFP(categoryTributaryPayroll.getRetentionAFP());
    }
}
