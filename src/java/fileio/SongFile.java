package fileio;

import dto.Song;
import java.io.BufferedReader;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.util.ArrayList;
import java.util.List;
import javax.servlet.ServletContext;

public class SongFile {

    public static List<Song> loadFromFile(ServletContext context) {
        List<Song> result = new ArrayList<>();

        try (InputStream is = context.getResourceAsStream("/WEB-INF/songs.txt");
             BufferedReader br = new BufferedReader(new InputStreamReader(is, "UTF-8"))) {

            String line;
            int lineNum = 0;
            while ((line = br.readLine()) != null) {
                lineNum++;
                if (line.trim().isEmpty()) continue;

                Song s = parseSong(line);
                if (s == null) {
                    System.out.println("Line " + lineNum + " skipped: invalid format");
                    continue;
                }
                if (isDuplicate(result, s.getId())) {
                    System.out.println("Line " + lineNum + " skipped: duplicate ID " + s.getId());
                    continue;
                }
                result.add(s);
            }
        } catch (Exception e) {
            System.out.println("Error loading songs: " + e.getMessage());
        }
        return result;
    }

    private static Song parseSong(String line) {
        try {
            String[] parts = line.split("\\|");
            if (parts.length != 4) return null;

            int id = Integer.parseInt(parts[0].trim());
            String title = parts[1].trim();
            String artist = parts[2].trim();
            int duration = Integer.parseInt(parts[3].trim());

            if (title.isEmpty() || artist.isEmpty()) return null;
            if (duration <= 0) return null;

            return new Song(id, title, artist, duration);
        } catch (Exception e) {
            return null;
        }
    }

    private static boolean isDuplicate(List<Song> list, int id) {
        for (Song s : list) {
            if (s.getId() == id) return true;
        }
        return false;
    }
}
