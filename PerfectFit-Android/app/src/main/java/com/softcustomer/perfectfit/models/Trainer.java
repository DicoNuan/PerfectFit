package com.softcustomer.perfectfit.models;

/**
 * Created by rahim on 23/08/17.
 */

public class Trainer extends Model {

    private String name;
    private String profession;
    private float rating;
    private int reviewCount;
    private String countryFlag;
    private String hourRate;
    private String profilePic;

    //TODO:remove this
    private int profileRes;
    private int profileWall;

    private String specialization;
    private String aboutMe;
    private String coaching;
    private String location;
    private String bio;


    public Trainer(String name, String profession, float rating, String countryFlag, String hourRate, int profileRes) {
        this.name = name;
        this.profession = profession;
        this.rating = rating;
        this.countryFlag = countryFlag;
        this.hourRate = hourRate;
        //this.profilePic = profilePic;
        this.profileRes = profileRes;
    }

    public Trainer(String name, String profession, float rating,
                   int reviewCount, String countryFlag, String hourRate,
                   String profilePic, int profileRes, int profileWall,
                   String specialization, String aboutMe, String coaching,
                   String location, String bio) {
        this.name = name;
        this.profession = profession;
        this.rating = rating;
        this.reviewCount = reviewCount;
        this.countryFlag = countryFlag;
        this.hourRate = hourRate;
        this.profilePic = profilePic;
        this.profileRes = profileRes;
        this.profileWall = profileWall;
        this.specialization = specialization;
        this.aboutMe = aboutMe;
        this.coaching = coaching;
        this.location = location;
        this.bio = bio;
    }

    public String getRatingText() {
        return this.rating + " (" + reviewCount + ") ";
    }

    public int getReviewCount() {
        return reviewCount;
    }

    public void setReviewCount(int reviewCount) {
        this.reviewCount = reviewCount;
    }

    public int getProfileWall() {
        return profileWall;
    }

    public void setProfileWall(int profileWall) {
        this.profileWall = profileWall;
    }

    public String getSpecialization() {
        return specialization;
    }

    public void setSpecialization(String specialization) {
        this.specialization = specialization;
    }

    public String getAboutMe() {
        return aboutMe;
    }

    public void setAboutMe(String aboutMe) {
        this.aboutMe = aboutMe;
    }

    public String getCoaching() {
        return coaching;
    }

    public void setCoaching(String coaching) {
        this.coaching = coaching;
    }

    public String getLocation() {
        return location;
    }

    public void setLocation(String location) {
        this.location = location;
    }

    public String getBio() {
        return bio;
    }

    public void setBio(String bio) {
        this.bio = bio;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getProfession() {
        return profession;
    }

    public void setProfession(String profession) {
        this.profession = profession;
    }

    public float getRating() {
        return rating;
    }

    public void setRating(float rating) {
        this.rating = rating;
    }

    public String getCountryFlag() {
        return countryFlag;
    }

    public void setCountryFlag(String countryFlag) {
        this.countryFlag = countryFlag;
    }

    public String getHourRate() {
        return hourRate;
    }

    public void setHourRate(String hourRate) {
        this.hourRate = hourRate;
    }

    public String getProfilePic() {
        return profilePic;
    }

    public void setProfilePic(String profilePic) {
        this.profilePic = profilePic;
    }

    public int getProfileRes() {
        return profileRes;
    }

    public void setProfileRes(int profileRes) {
        this.profileRes = profileRes;
    }
}
