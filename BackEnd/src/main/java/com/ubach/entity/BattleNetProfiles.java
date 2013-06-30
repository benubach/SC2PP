/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package com.ubach.entity;

import java.io.Serializable;
import javax.persistence.Basic;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.NamedQueries;
import javax.persistence.NamedQuery;
import javax.persistence.Table;
import javax.validation.constraints.Size;
import javax.xml.bind.annotation.XmlRootElement;

/**
 *
 * @author dubach
 */
@Entity
@Table(name = "battle_net_profiles", catalog = "sc2web", schema = "security_stuff")
@XmlRootElement
@NamedQueries({
    @NamedQuery(name = "BattleNetProfiles.findAll", query = "SELECT b FROM BattleNetProfiles b"),
    @NamedQuery(name = "BattleNetProfiles.findByBnetId", query = "SELECT b FROM BattleNetProfiles b WHERE b.bnetId = :bnetId"),
    @NamedQuery(name = "BattleNetProfiles.findByBnetUrl", query = "SELECT b FROM BattleNetProfiles b WHERE b.bnetUrl = :bnetUrl"),
    @NamedQuery(name = "BattleNetProfiles.findByStarcraftRace", query = "SELECT b FROM BattleNetProfiles b WHERE b.starcraftRace = :starcraftRace"),
    @NamedQuery(name = "BattleNetProfiles.findByExpansionLevel", query = "SELECT b FROM BattleNetProfiles b WHERE b.expansionLevel = :expansionLevel"),
    @NamedQuery(name = "BattleNetProfiles.findByUserAndCharcode", query = "SELECT b FROM BattleNetProfiles b WHERE b.userAndCharcode = :userAndCharcode"),
    @NamedQuery(name = "BattleNetProfiles.findByLeagueCurrent", query = "SELECT b FROM BattleNetProfiles b WHERE b.leagueCurrent = :leagueCurrent"),
    @NamedQuery(name = "BattleNetProfiles.findByCoachingLowerLeague", query = "SELECT b FROM BattleNetProfiles b WHERE b.coachingLowerLeague = :coachingLowerLeague"),
    @NamedQuery(name = "BattleNetProfiles.findBySearchingLeague", query = "SELECT b FROM BattleNetProfiles b WHERE b.searchingLeague = :searchingLeague")})
public class BattleNetProfiles implements Serializable {
    private static final long serialVersionUID = 1L;
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Basic(optional = false)
    @Column(name = "bnet_id")
    private Long bnetId;
    @Size(max = 2147483647)
    @Column(name = "bnet_url")
    private String bnetUrl;
    @Size(max = 15)
    @Column(name = "starcraft_race")
    private String starcraftRace;
    @Column(name = "expansion_level")
    private Integer expansionLevel;
    @Size(max = 255)
    @Column(name = "user_and_charcode")
    private String userAndCharcode;
    @Column(name = "league_current")
    private Integer leagueCurrent;
    @Column(name = "coaching_lower_league")
    private Boolean coachingLowerLeague;
    @Size(max = 10)
    @Column(name = "searching_league")
    private String searchingLeague;
    @JoinColumn(name = "profile_id", referencedColumnName = "login_id")
    @ManyToOne
    private PpLoginData profileId;

    public BattleNetProfiles() {
    }

    public BattleNetProfiles(Long bnetId) {
        this.bnetId = bnetId;
    }

    public Long getBnetId() {
        return bnetId;
    }

    public void setBnetId(Long bnetId) {
        this.bnetId = bnetId;
    }

    public String getBnetUrl() {
        return bnetUrl;
    }

    public void setBnetUrl(String bnetUrl) {
        this.bnetUrl = bnetUrl;
    }

    public String getStarcraftRace() {
        return starcraftRace;
    }

    public void setStarcraftRace(String starcraftRace) {
        this.starcraftRace = starcraftRace;
    }

    public Integer getExpansionLevel() {
        return expansionLevel;
    }

    public void setExpansionLevel(Integer expansionLevel) {
        this.expansionLevel = expansionLevel;
    }

    public String getUserAndCharcode() {
        return userAndCharcode;
    }

    public void setUserAndCharcode(String userAndCharcode) {
        this.userAndCharcode = userAndCharcode;
    }

    public Integer getLeagueCurrent() {
        return leagueCurrent;
    }

    public void setLeagueCurrent(Integer leagueCurrent) {
        this.leagueCurrent = leagueCurrent;
    }

    public Boolean getCoachingLowerLeague() {
        return coachingLowerLeague;
    }

    public void setCoachingLowerLeague(Boolean coachingLowerLeague) {
        this.coachingLowerLeague = coachingLowerLeague;
    }

    public String getSearchingLeague() {
        return searchingLeague;
    }

    public void setSearchingLeague(String searchingLeague) {
        this.searchingLeague = searchingLeague;
    }

    public PpLoginData getProfileId() {
        return profileId;
    }

    public void setProfileId(PpLoginData profileId) {
        this.profileId = profileId;
    }

    @Override
    public int hashCode() {
        int hash = 0;
        hash += (bnetId != null ? bnetId.hashCode() : 0);
        return hash;
    }

    @Override
    public boolean equals(Object object) {
        // TODO: Warning - this method won't work in the case the id fields are not set
        if (!(object instanceof BattleNetProfiles)) {
            return false;
        }
        BattleNetProfiles other = (BattleNetProfiles) object;
        if ((this.bnetId == null && other.bnetId != null) || (this.bnetId != null && !this.bnetId.equals(other.bnetId))) {
            return false;
        }
        return true;
    }

    @Override
    public String toString() {
        return "com.ubach.entity.BattleNetProfiles[ bnetId=" + bnetId + " ]";
    }
    
}
