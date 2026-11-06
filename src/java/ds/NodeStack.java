/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package ds;

import dto.SongHistory;

/**
 *
 * @author kayng
 */
public class NodeStack {
    protected SongHistory songHistory;
    protected NodeStack next;

    public NodeStack(SongHistory songHistory, NodeStack next) {
        this.songHistory = songHistory;
        this.next = next;
    }
    
    public NodeStack(SongHistory songHistory) {
        this(songHistory, null);
    }

    public SongHistory getSongHistory() {
        return songHistory;
    }

    public void setSongHistory(SongHistory songHistory) {
        this.songHistory = songHistory;
    }

    public NodeStack getNext() {
        return next;
    }

    public void setNext(NodeStack next) {
        this.next = next;
    }
    
    
}
