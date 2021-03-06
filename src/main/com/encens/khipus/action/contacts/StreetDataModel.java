package com.encens.khipus.action.contacts;

import com.encens.khipus.framework.action.QueryDataModel;
import com.encens.khipus.model.contacts.Street;
import org.jboss.seam.ScopeType;
import org.jboss.seam.annotations.Create;
import org.jboss.seam.annotations.Name;
import org.jboss.seam.annotations.Scope;
import org.jboss.seam.annotations.security.Restrict;

import java.util.Arrays;
import java.util.List;

/**
 * Data model for Street
 *
 * @author:
 */

@Name("streetDataModel")
@Scope(ScopeType.PAGE)
@Restrict("#{s:hasPermission('STREET','VIEW')}")
public class StreetDataModel extends QueryDataModel<Long, Street> {

    private static final String[] RESTRICTIONS =
            {"lower(street.name) like concat('%', concat(lower(#{streetDataModel.criteria.name}), '%'))"};

    @Create
    public void init() {
        sortProperty = "street.name";
    }

    @Override
    public String getEjbql() {
        return "select street from Street street";
    }

    @Override
    public List<String> getRestrictions() {
        return Arrays.asList(RESTRICTIONS);
    }
}
