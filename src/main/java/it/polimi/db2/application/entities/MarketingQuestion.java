package it.polimi.db2.application.entities;

import javax.persistence.*;


@Entity
@Table(name = "questions_marketing", schema = "marketing_application")
public class MarketingQuestion {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private int id;
    private String question;

    @Enumerated(EnumType.STRING)
    private QuestionType type;

    @ManyToOne
    @JoinColumn(name="questionnaire_id")
    private Questionnaire questionnaire;

    public MarketingQuestion() {
    }

    public MarketingQuestion(String question, QuestionType type) {
        this.question = question;
        this.type = type;
    }

    public String getQuestion() {
        return question;
    }

    public QuestionType getType() {
        return type;
    }

    public void setQuestionnaire(Questionnaire questionnaire) {
        this.questionnaire = questionnaire;
    }
}
