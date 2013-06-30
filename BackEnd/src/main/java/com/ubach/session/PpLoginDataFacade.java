/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package com.ubach.session;

import com.ubach.entity.PpLoginData;
import javax.ejb.Stateless;
import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;

/**
 *
 * @author dubach
 */
@Stateless
public class PpLoginDataFacade extends AbstractFacade<PpLoginData> {
    @PersistenceContext(unitName = "com.ubach_SC2PP_BE_war_1.0-SNAPSHOTPU")
    private EntityManager em;

    @Override
    protected EntityManager getEntityManager() {
        return em;
    }

    public PpLoginDataFacade() {
        super(PpLoginData.class);
    }
    
}
