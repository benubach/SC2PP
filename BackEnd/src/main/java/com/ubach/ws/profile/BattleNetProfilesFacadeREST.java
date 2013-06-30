/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package com.ubach.ws.profile;

import com.ubach.entity.BattleNetProfiles;
import java.util.List;
import javax.ejb.Stateless;
import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;
import javax.ws.rs.Consumes;
import javax.ws.rs.DELETE;
import javax.ws.rs.GET;
import javax.ws.rs.POST;
import javax.ws.rs.PUT;
import javax.ws.rs.Path;
import javax.ws.rs.PathParam;
import javax.ws.rs.Produces;

/**
 *
 * @author dubach
 */
@Stateless
@Path("battlenetprofiles")
public class BattleNetProfilesFacadeREST extends AbstractFacade<BattleNetProfiles> {
    @PersistenceContext(unitName = "com.ubach_SC2PP_BE_war_1.0-SNAPSHOTPU")
    private EntityManager em;

    public BattleNetProfilesFacadeREST() {
        super(BattleNetProfiles.class);
    }

    @POST
    @Override
    @Consumes({"application/xml", "application/json"})
    public void create(BattleNetProfiles entity) {
        super.create(entity);
    }

    @PUT
    @Override
    @Consumes({"application/xml", "application/json"})
    public void edit(BattleNetProfiles entity) {
        super.edit(entity);
    }

    @DELETE
    @Path("{id}")
    public void remove(@PathParam("id") Long id) {
        super.remove(super.find(id));
    }

    @GET
    @Path("{id}")
    @Produces({"application/xml", "application/json"})
    public BattleNetProfiles find(@PathParam("id") Long id) {
        return super.find(id);
    }

    @GET
    @Override
    @Produces({"application/xml","application/json"})
    public List<BattleNetProfiles> findAll() {
        return super.findAll();
    }

    @GET
    @Path("{from}/{to}")
    @Produces({"application/xml", "application/json"})
    public List<BattleNetProfiles> findRange(@PathParam("from") Integer from, @PathParam("to") Integer to) {
        return super.findRange(new int[]{from, to});
    }

    @GET
    @Path("count")
    @Produces("text/plain")
    public String countREST() {
        return String.valueOf(super.count());
    }

    @Override
    protected EntityManager getEntityManager() {
        return em;
    }
    
}
