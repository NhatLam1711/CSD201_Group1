/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package ds;

import dto.Song;

/**
 *
 * @author Tung Nguyen
 */
public class NodeTree {
    Song song;
    NodeTree left, right;

    public NodeTree() {
    }

    public NodeTree(Song song, NodeTree left, NodeTree right) {
        this.song = song;
        this.left = left;
        this.right = right;
    }

    public Song getSong() {
        return song;
    }

    public void setSong(Song song) {
        this.song = song;
    }

    public NodeTree getLeft() {
        return left;
    }

    public void setLeft(NodeTree left) {
        this.left = left;
    }

    public NodeTree getRight() {
        return right;
    }

    public void setRight(NodeTree right) {
        this.right = right;
    }
}
