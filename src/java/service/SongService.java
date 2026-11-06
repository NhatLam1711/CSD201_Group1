/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package service;

import dao.SongDAO;
import ds.NodeStack;
import ds.Stack;
import dto.Song;
import dto.SongHistory;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

/**
 *
 * @author kayng
 */
public class SongService {
    private Stack stackHistory;
    
    

    public SongService() throws IOException {
        stackHistory = new Stack();
        SongDAO dao = new SongDAO();
        for (SongHistory h : dao.downloadHistory()) {
            stackHistory.push(h);
            
        }
        
    }

    public SongService(Stack stackHistory) {
        this.stackHistory = stackHistory;
    }

    public Stack getStackHistory() {
        return stackHistory;
    }

    public void addHistory(Song song) {
        stackHistory.push(new SongHistory(song));
        System.out.println("Added to history: " + song.getTitle());
    }
    
    public List<SongHistory> getListHistory(){
        NodeStack n = stackHistory.getTop();
        List<SongHistory> listHistory = new ArrayList<>();
        while(n != null){
            listHistory.add(n.getSongHistory());
            n = n.getNext();
        }
        return listHistory;
    }
}
