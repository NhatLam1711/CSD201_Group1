/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dao;

import dto.Song;
import dto.SongHistory;
import java.io.BufferedReader;
import java.io.BufferedWriter;
import java.io.File;
import java.io.IOException;
import java.nio.charset.StandardCharsets;
import java.nio.file.Files;
import java.nio.file.Paths;
import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.List;

/**
 * Lưu / đọc bài hát và lịch sử nghe nhạc bằng file .txt.
 *
 * songs.txt    mỗi dòng: id|title|artist|durationSec
 * history.txt  mỗi dòng: songId|title|artist|durationSec|playedAt
 */
public class SongDAO {

    private static final String SONGS_FILE = "E:/CSD201/PlaylistPage/songs.txt";
    private static final String HISTORY_FILE = "E:/CSD201/PlaylistPage/history.txt";

    // ---------- SONG ----------

    public void uploadSongs(List<Song> songs) throws IOException {
        try (BufferedWriter w = Files.newBufferedWriter(
                Paths.get(SONGS_FILE), StandardCharsets.UTF_8)) {
            for (Song s : songs) {
                w.write(s.getId() + "|" + s.getTitle() + "|" + s.getArtist() + "|" + s.getDurationSec());
                w.newLine();
            }
        }
    }

    public List<Song> downloadSongs() throws IOException {
        List<Song> songs = new ArrayList<>();
        File file = new File(SONGS_FILE);
        if (!file.exists()) {
            return songs;
        }
        try (BufferedReader r = Files.newBufferedReader(file.toPath(), StandardCharsets.UTF_8)) {
            String line;
            while ((line = r.readLine()) != null) {
                String[] p = line.split("\\|");
                songs.add(new Song(Integer.parseInt(p[0]), p[1], p[2], Integer.parseInt(p[3])));
            }
        }
        return songs;
    }

    // ---------- HISTORY ----------

    public void uploadHistory(List<SongHistory> history) throws IOException {
        try (BufferedWriter w = Files.newBufferedWriter(
                Paths.get(HISTORY_FILE), StandardCharsets.UTF_8)) {
            for (SongHistory h : history) {
                w.write(h.getSongId() + "|" + h.getTitle() + "|" + h.getArtist() + "|"
                        + h.getDurationSec() + "|" + h.getPlayedAt());
                w.newLine();
            }
        }
    }

    public List<SongHistory> downloadHistory() throws IOException {
        List<SongHistory> history = new ArrayList<>();
        File file = new File(HISTORY_FILE);
        if (!file.exists()) {
            System.out.println("Not exist");
            return history;
        }
        try (BufferedReader r = Files.newBufferedReader(file.toPath(), StandardCharsets.UTF_8)) {
            String line;
            while ((line = r.readLine()) != null) {
                String[] p = line.split("\\|");
                Song song = new Song(Integer.parseInt(p[0]), p[1], p[2], Integer.parseInt(p[3]));
                history.add(new SongHistory(song, LocalDateTime.parse(p[4])));
            }
        }
        
        return history;
    }
}