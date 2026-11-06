/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package service;

import ds.NodeTree;
import ds.SongBST;
import dto.Song;
import java.util.ArrayList;
import java.util.List;

/**
 *
 * @author Tung Nguyen
 */
public class SongTreeService {
    
    private SongBST tree;

    public SongTreeService(SongBST tree) {
        this.tree = tree;
    }

    public SongTreeService() {
    }

    
    
    public List<Song> searchByKeyword(String keyword) {
        List<Song> results = new ArrayList<>();
        if (keyword != null && !keyword.trim().isEmpty()) {
            searchKeywordRec(tree.getRoot(), keyword.toLowerCase().trim(), results);
        }
        return results;
    }

    private void searchKeywordRec(NodeTree node, String keyword, List<Song> results) {
        if (node == null) return;
        searchKeywordRec(node.getLeft(), keyword, results);
        if (node.getSong().getTitle().toLowerCase().contains(keyword))
            results.add(node.getSong());
        searchKeywordRec(node.getRight(), keyword, results);
    }
}
