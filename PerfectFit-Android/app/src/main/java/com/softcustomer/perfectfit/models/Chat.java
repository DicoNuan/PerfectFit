package com.softcustomer.perfectfit.models;




public class Chat extends Model {

    private Trainer trainer;
    private Message lastMessage;

    public Chat(Message lastMessage, Trainer trainer) {
        super();
        this.lastMessage = lastMessage;
        this.trainer = trainer;
    }

    public Message getLastMessage() {
        return lastMessage;
    }

    public void setLastMessage(Message lastMessage) {
        this.lastMessage = lastMessage;
    }

    public Trainer getTrainer() {
        return trainer;
    }

    public void setTrainer(Trainer trainer) {
        this.trainer = trainer;
    }

}
