package com.softcustomer.perfectfit.utils;

import android.content.Context;

import com.softcustomer.perfectfit.R;
import com.softcustomer.perfectfit.models.Chat;
import com.softcustomer.perfectfit.models.Message;
import com.softcustomer.perfectfit.models.Review;
import com.softcustomer.perfectfit.models.Session;
import com.softcustomer.perfectfit.models.Trainer;
import com.softcustomer.perfectfit.models.Transaction;

import java.util.ArrayList;
import java.util.Date;
import java.util.Random;

/**
 * Created by rahim on 23/08/17.
 */

public class DummyData {


    public static ArrayList<Trainer> getTrainers() {
        ArrayList<Trainer> trainers = new ArrayList<>();

        trainers.add(new Trainer(
                "Anna Keller", "MMA - martial arts - Box",
                4.7f, "", "15 KD/hr", R.raw.profile1));

        trainers.add(new Trainer(
                "Alina Fischer", "Fitness - hot iron - Flex",
                5.0f, "", "20 KD/hr", R.raw.profile2));

        trainers.add(new Trainer(
                "Sansa stark", "Winterfell - hot iron - Flex",
                4.7f, "", "17 KD/hr", R.raw.profile3));

        trainers.add(new Trainer(
                "Serceii Lanister", "Dragonstone - hot iron - Flex",
                3.3f, "", "13 KD/hr", R.raw.profile4));

        return trainers;
    }


    public static ArrayList<Trainer> getTrainers(Context context) {
        ArrayList<Trainer> trainers = getTrainers();
        for (Trainer trainer : trainers) {
            trainer.setReviewCount(new Random().nextInt(100));
            trainer.setProfileWall(R.raw.profile_wall1);
            trainer.setSpecialization(context.getString(R.string.dummy_specialization));
            trainer.setAboutMe(context.getString(R.string.dummy_bio));
            trainer.setCoaching(context.getString(R.string.dummy_coaching));
            trainer.setLocation(context.getString(R.string.dummy_location));
            trainer.setBio(context.getString(R.string.dummy_bio));
        }
        return trainers;
    }

    public static Trainer getTrainer() {
        return new Trainer(
                "Serceii Lanister", "Dragonstone - hot iron - Flex",
                3.3f, "", "13 KD/hr", R.raw.profile4);
    }

    public static ArrayList<Chat> getChats(String text) {
        ArrayList<Chat> chats = new ArrayList<>();
        for (Trainer trainer : getTrainers()) {
            Message message = new Message(text, getRandomDate());
            Chat chat = new Chat(message, trainer);
            chats.add(chat);
        }
        return chats;
    }

    public static Date getRandomDate() {
        Random random = new Random();
        long minutes = random.nextInt() * 60 * 1000;
        long hours = minutes + 60 * random.nextInt();
        long days = hours + 24 * random.nextInt(15);
        long newDate = System.currentTimeMillis() - days;
        return new Date(newDate);
    }

    public static ArrayList<Message> getMessages() {
        ArrayList<Message> messages = new ArrayList<>();
        messages.add(new Message("Type something", getRandomDate(), false));
        messages.add(new Message("Secondary line text lorem ipsum dapibus, neque id cursus faucibus", getRandomDate(), false));
        messages.add(new Message("Secondary line text lorem ipsum dapibus, neque id cursus faucibus", getRandomDate(), true));
        messages.add(new Message("Hello world", getRandomDate(), false));
        messages.add(new Message("Dummy text", getRandomDate(), true));
        messages.add(new Message("Message 3", getRandomDate(), false));
        messages.add(new Message("Helloooo", getRandomDate(), true));
        messages.add(new Message("Hello back", getRandomDate(), true));
        messages.add(new Message("Hello back", getRandomDate(), true));
        return messages;
    }

    public static ArrayList<Transaction> getTransactions() {
        ArrayList<Transaction> transactions = new ArrayList<>();
        transactions.add(new Transaction("75 KD", "Amanda Fishcer", "15 oct"));
        transactions.add(new Transaction("72 KD", "John Fishcer", "16 sep"));
        transactions.add(new Transaction("73 KD", "George Fishcer", "5 june"));
        return transactions;
    }

    public static ArrayList<Session> getSessions() {
        ArrayList<Session> sessions = new ArrayList<>();
        sessions.add(new Session("Amanda Fishcer", "Badminton", "18 oct", "10:00", "12:00"));
        sessions.add(new Session("Amanda Fishcer", "VolleyBall", "18 nov", "10:00", "12:00"));
        sessions.add(new Session("Amanda Fishcer", "Football", "18 jun", "10:00", "12:00"));
        return sessions;
    }

    public static ArrayList<Review> getReviews() {
        ArrayList<Review> reviews = new ArrayList<>();
        reviews.add(new Review("Amanda Fischer", "",
                "Secondary line text lorem ipsum dapibus, neque id cursus faucibus", 4.5f));

        reviews.add(new Review("Amanda Fischer", "",
                "Secondary line text lorem ipsum dapibus, neque id cursus faucibus", 3.5f));
        return reviews;
    }
}
