package com.encens.khipus.action.products;

import com.encens.khipus.framework.action.QueryDataModel;
import com.encens.khipus.model.products.ProductType;
import org.jboss.seam.ScopeType;
import org.jboss.seam.annotations.Create;
import org.jboss.seam.annotations.Name;
import org.jboss.seam.annotations.Scope;
import org.jboss.seam.annotations.security.Restrict;

import java.util.Arrays;
import java.util.List;

/**
 * @author:
 */
@Name("productTypeDataModel")
@Scope(ScopeType.PAGE)
@Restrict("#{s:hasPermission('PRODUCTTYPE','VIEW')}")
public class ProductTypeDataModel extends QueryDataModel<Long, ProductType> {

    private static final String[] RESTRICTIONS =
            {"lower(productType.name) like concat('%', concat(lower(#{productTypeDataModel.criteria.name}), '%'))"};

    @Create
    public void init() {
        sortProperty = "productType.name";
    }

    @Override
    public String getEjbql() {
        return "select productType from ProductType productType";
    }

    @Override
    public List<String> getRestrictions() {
        return Arrays.asList(RESTRICTIONS);
    }
}
