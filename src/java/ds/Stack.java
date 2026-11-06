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
public class Stack {
    private NodeStack top;
    
    public void push(SongHistory h) {
        NodeStack node = new NodeStack(h);
        node.next = top;
        top = node;
    }
 
    public SongHistory pop() {
        if (top == null) {
            return null;
        }
        SongHistory h = top.songHistory;
        top = top.next;
        return h;
    }

    public NodeStack getTop() {
        return top;
    }

    public void setTop(NodeStack top) {
        this.top = top;
    }
    
    
}
