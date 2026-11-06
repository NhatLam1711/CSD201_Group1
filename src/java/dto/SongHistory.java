/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dto;

import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;

/**
 *
 * @author kayng
 */
public class SongHistory {
 
    private static final DateTimeFormatter FORMATTER =
            DateTimeFormatter.ofPattern("dd/MM/yyyy HH:mm:ss");
 
    // Chụp lại (snapshot) thông tin bài hát tại thời điểm nghe
    private final int songId;
    private final String title;
    private final String artist;
    private final int durationSec;
 
    private final LocalDateTime playedAt;
 
    public SongHistory(Song song) {
        this(song, LocalDateTime.now());
    }

    public SongHistory(Song song, LocalDateTime playedAt) {
        if (song == null) {
            throw new IllegalArgumentException("song must not be null");
        }
        if (playedAt == null) {
            throw new IllegalArgumentException("playedAt must not be null");
        }
        this.songId = song.getId();
        this.title = song.getTitle();
        this.artist = song.getArtist();
        this.durationSec = song.getDurationSec();
        this.playedAt = playedAt;
    }
 
    public int getSongId() {
        return songId;
    }
 
    public String getTitle() {
        return title;
    }
 
    public String getArtist() {
        return artist;
    }
 
    public int getDurationSec() {
        return durationSec;
    }
 
    public LocalDateTime getPlayedAt() {
        return playedAt;
    }
 
    /** 215 -> "3:35" */
    public String getFormattedDuration() {
        return (durationSec / 60) + ":" + String.format("%02d", durationSec % 60);
    }
 
    /** "02/11/2026 20:22:05" */
    public String getFormattedPlayedAt() {
        return playedAt.format(FORMATTER);
    }
 
    @Override
    public String toString() {
        return "[" + getFormattedPlayedAt() + "] "
                + title + " - " + artist + " (" + getFormattedDuration() + ")";
    }
}
