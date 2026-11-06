/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package ds;

import dto.Song;
import java.util.ArrayList;
import java.util.List;

/**
 *
 * @author Tung Nguyen
 */
public class SongBST {
    private NodeTree root;
    private int size;

    public SongBST() {
        root = null;
        size = 0;
    }

    // ========== BUILD BALANCED ==========
    public void buildBalanced(List<Song> sortedList) {
        this.size = sortedList.size();
        this.root = buildBalancedRec(sortedList, 0, sortedList.size() - 1);
    }

    private NodeTree buildBalancedRec(List<Song> list, int start, int end) {
        if (start > end) return null;
        int mid = (start + end) / 2;
        NodeTree node = new NodeTree(list.get(mid), null, null);
        node.setLeft(buildBalancedRec(list, start, mid - 1));
        node.setRight(buildBalancedRec(list, mid + 1, end));
        return node;
    }

   
    void insert(Song song) {
        if (root == null) {
            root = new NodeTree(song, null, null);
            size++;
            return;
        }
        NodeTree f, p;
        p = root;
        f = null;
        while (p != null) {
            if (p.getSong().getId() == song.getId()) {
                System.out.println("The key " + song.getId()
                    + " already exists, no insertion");
                return;
            }
            f = p;
            if (song.getId() < p.getSong().getId())
                p = p.getLeft();
            else
                p = p.getRight();
        }
        if (song.getId() < f.getSong().getId())
            f.setLeft(new NodeTree(song, null, null));
        else
            f.setRight(new NodeTree(song, null, null));
        size++;
    }

    // ========== SEARCH BY ID ==========
    public NodeTree search(NodeTree p, int id) {
        if (p == null) return null;
        if (p.getSong().getId() == id) return p;
        if (id < p.getSong().getId())
            return search(p.getLeft(), id);
        else
            return search(p.getRight(), id);
    }

    // ========== INORDER LIST ==========
    public List<Song> inorderList() {
        List<Song> results = new ArrayList<>();
        inOrder(root, results);
        return results;
    }

    private void inOrder(NodeTree p, List<Song> results) {
        if (p == null) return;
        inOrder(p.getLeft(), results);
        results.add(p.getSong());
        inOrder(p.getRight(), results);
    }

    public NodeTree getRoot() { return root; }
    public int getSize() { return size; }
}
