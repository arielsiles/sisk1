package com.encens.khipus.service.employees;

import com.encens.khipus.exception.EntryDuplicatedException;
import com.encens.khipus.framework.service.GenericService;
import com.encens.khipus.model.employees.DismissalCause;

import javax.ejb.Local;
import javax.ejb.TransactionAttribute;

import static javax.ejb.TransactionAttributeType.REQUIRES_NEW;

/**
 * @author
 * @version 3.4
 */
@Local
public interface DismissalCauseService extends GenericService {
    @TransactionAttribute(REQUIRES_NEW)
    void createDismissalCause(DismissalCause dismissalCause) throws EntryDuplicatedException;
}
