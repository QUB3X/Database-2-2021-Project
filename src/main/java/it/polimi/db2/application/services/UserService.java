package it.polimi.db2.application.services;

import javax.ejb.Stateless;
import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;
import javax.persistence.PersistenceException;
import javax.persistence.NonUniqueResultException;

import it.polimi.db2.application.entities.LoginLog;
import it.polimi.db2.application.entities.User;
import it.polimi.db2.application.exceptions.*;

import java.util.Date;
import java.util.List;

@Stateless
public class UserService {
	@PersistenceContext(unitName = "MarketingApplicationEJB")
	private EntityManager em;

	public UserService() {
	}

	public User checkCredentials(String usrn, String pwd) throws CredentialsException, NonUniqueResultException {
		List<User> uList = null;
		try {
			uList = em.createNamedQuery("User.checkCredentials", User.class).setParameter(1, usrn).setParameter(2, pwd).getResultList();
		} catch (PersistenceException e) {
			throw new CredentialsException("Could not verify credentals");
		}
		if (uList.isEmpty())
			return null;
		else if (uList.size() == 1) {
			User user = uList.get(0);

			LoginLog log = new LoginLog(user, new Date(System.currentTimeMillis()));
			em.persist(log);

			return user;
		}
		throw new NonUniqueResultException("More than one user registered with same credentials");
	}

	public void banUser(User user) {
		user.setBanned(true);
		em.merge(user);
	}

	public void setCompilationRequested(User user) {
		user.getLastLog().setCompilation_requested(true);
		em.merge(user);
	}

	public void setCompilationCompleted(User user) {
		user.getLastLog().setCompilation_completed(true);
		em.merge(user);
	}

	public List<User> getUsersWhoSubmittedQuestionnaire(String questionnaireId) {
		List<User> users = em.createNamedQuery("User.getUsersWhoSubmittedQuestionnaire", User.class).setParameter(1, questionnaireId).getResultList();
		return users;
	}

	public List<User> getUsersWhoCancelledQuestionnaire(String questionnaireId) {
		List<User> users = em.createNamedQuery("User.getUsersWhoCancelledQuestionnaire", User.class).setParameter(1, questionnaireId).getResultList();
		return users;
	}
}
