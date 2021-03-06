package it.polimi.db2.application.entities;

import javax.persistence.*;
import java.io.Serializable;
import java.sql.Timestamp;
import java.util.Date;

/**
 * This class is needed for the creation of a composite key for the LoginLog class
 */
class LoginLogId {
	private int user;
	private Date timestamp;
	public LoginLogId(){
	}
}

/**
 * This is the entity corresponding to the login_logs table in the database.
 */
@Entity
@IdClass(LoginLogId.class)
@Table(name = "login_logs", schema = "marketing_application")
public class LoginLog implements Serializable {
	private static final long serialVersionUID = 1L;

	@Id
	private Date timestamp;

	@Id
	@ManyToOne
	@JoinColumn(name= "user_id")
	private User user;

	Boolean compilation_requested; //TRUE if the user requested a compilation of the questionnaire of the day
	Boolean compilation_completed; //TRUE if the user completed the questionnaire of the day


	//CONSTRUCTORS

	public LoginLog() {
	}

	public LoginLog(User user, Date timestamp){
		this.user=user;
		this.timestamp=timestamp;
		this.compilation_completed = false;
		this.compilation_requested = false;
		user.addNewLog(this);
	}


	//GETTER & SETTERS

	public Boolean getCompilation_requested() {
		return compilation_requested;
	}
	public void setCompilation_requested(Boolean compilation_requested) {
		this.compilation_requested = compilation_requested;
	}
	public Boolean getCompilation_completed() {
		return compilation_completed;
	}
	public void setCompilation_completed(Boolean compilation_completed) {
		this.compilation_completed = compilation_completed;
	}
	public Date getTimestamp() {
		return timestamp;
	}

}
