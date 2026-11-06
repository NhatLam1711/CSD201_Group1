package dto;

public class Song {
    private int id;
    private String title;
    private String artist;
    private int durationSec;

    public Song(int id, String title, String artist, int durationSec) {
        this.id = id;
        this.title = title;
        this.artist = artist;
        this.durationSec = durationSec;
    }

    public Song() {
    }

    public int getId() { return id; }
    public void setId(int id) { this.id = id; }

    public String getTitle() { return title; }
    public void setTitle(String title) { this.title = title; }

    public String getArtist() { return artist; }
    public void setArtist(String artist) { this.artist = artist; }

    public int getDurationSec() { return durationSec; }
    public void setDurationSec(int durationSec) { this.durationSec = durationSec; }

    /** 234 -> "3:54" */
    public String getFormattedDuration() {
        return (durationSec / 60) + ":" + String.format("%02d", durationSec % 60);
    }
}
