/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package com.ubach.entity;

import java.io.Serializable;
import java.util.Collection;
import javax.persistence.Basic;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.NamedQueries;
import javax.persistence.NamedQuery;
import javax.persistence.OneToMany;
import javax.persistence.Table;
import javax.validation.constraints.Size;
import javax.xml.bind.annotation.XmlRootElement;
import javax.xml.bind.annotation.XmlTransient;

/**
 *
 * @author dubach
 */
@Entity
@Table(name = "pp_login_data", catalog = "sc2web", schema = "security_stuff")
@XmlRootElement
@NamedQueries({
    @NamedQuery(name = "PpLoginData.findAll", query = "SELECT p FROM PpLoginData p"),
    @NamedQuery(name = "PpLoginData.findByLoginId", query = "SELECT p FROM PpLoginData p WHERE p.loginId = :loginId"),
    @NamedQuery(name = "PpLoginData.findByEmail", query = "SELECT p FROM PpLoginData p WHERE p.email = :email"),
    @NamedQuery(name = "PpLoginData.findBySha256Pass", query = "SELECT p FROM PpLoginData p WHERE p.sha256Pass = :sha256Pass")})
public class PpLoginData implements Serializable {
    private static final long serialVersionUID = 1L;
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Basic(optional = false)
    @Column(name = "login_id")
    private Long loginId;
    // @Pattern(regexp="[a-z0-9!#$%&'*+/=?^_`{|}~-]+(?:\\.[a-z0-9!#$%&'*+/=?^_`{|}~-]+)*@(?:[a-z0-9](?:[a-z0-9-]*[a-z0-9])?\\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?", message="Invalid email")//if the field contains email address consider using this annotation to enforce field validation
    @Size(max = 2147483647)
    private String email;
    @Size(max = 68)
    @Column(name = "sha256_pass")
    private String sha256Pass;
    
    public PpLoginData() {
    }

    public PpLoginData(Long loginId) {
        this.loginId = loginId;
    }

    public Long getLoginId() {
        return loginId;
    }

    public void setLoginId(Long loginId) {
        this.loginId = loginId;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public String getSha256Pass() {
        return sha256Pass;
    }

    public void setSha256Pass(String sha256Pass) {
        this.sha256Pass = sha256Pass;
    }

   

    @Override
    public int hashCode() {
        int hash = 0;
        hash += (loginId != null ? loginId.hashCode() : 0);
        return hash;
    }

    @Override
    public boolean equals(Object object) {
        // TODO: Warning - this method won't work in the case the id fields are not set
        if (!(object instanceof PpLoginData)) {
            return false;
        }
        PpLoginData other = (PpLoginData) object;
        if ((this.loginId == null && other.loginId != null) || (this.loginId != null && !this.loginId.equals(other.loginId))) {
            return false;
        }
        return true;
    }

    @Override
    public String toString() {
        return "com.ubach.entity.PpLoginData[ loginId=" + loginId + " ]";
    }
    
}
