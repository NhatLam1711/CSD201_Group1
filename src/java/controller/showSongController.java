package controller;

import ds.SongBST;
import ds.NodeTree;
import dto.Song;
import fileio.SongFile;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import service.SongService;
import service.SongTreeService;

@WebServlet(name = "showSongController", urlPatterns = {"/showSongController"})
public class showSongController extends HttpServlet {
    private SongBST bst;
    private SongTreeService treeService;

    @Override
    public void init() throws ServletException {
        
        List<Song> songs = SongFile.loadFromFile(getServletContext());
        bst = new SongBST();
        bst.buildBalanced(songs);

        
        SongService songService;
        try {
            songService = new SongService();
        } catch (IOException e) {
            System.out.println("Error init SongService: " + e.getMessage());
            songService = new SongService(new ds.Stack()); 
        }
        getServletContext().setAttribute("SONG_SERVICE", songService);

        treeService = new SongTreeService(bst);
        System.out.println("=== SongBST loaded: " + bst.getSize() + " songs ===");
    }

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");

        String action = request.getParameter("action");

        // luu danh sach bai hat da nghe vao lich su
        if ("play".equals(action)) {
            int songId = Integer.parseInt(request.getParameter("songId"));
            NodeTree found = bst.search(bst.getRoot(), songId);
            SongService songService = (SongService) getServletContext().getAttribute("SONG_SERVICE");
            if (found != null && songService != null) {
                songService.addHistory(found.getSong());
            }
            response.sendRedirect("showSongController");
            return;
        }

        // hien thi danh sach/ tim kiem
        try (PrintWriter out = response.getWriter()) {
            String keyword = request.getParameter("KEYWORD");
            List<Song> songList;

            if (keyword != null && !keyword.trim().isEmpty()) {
                songList = treeService.searchByKeyword(keyword.trim());
            } else {
                songList = bst.inorderList();
                keyword = "";
            }

            request.setAttribute("SONGLIST", songList);
            request.setAttribute("KEYWORD", keyword);
            request.setAttribute("TOTALSONG", bst.getSize());

            RequestDispatcher rd = request.getRequestDispatcher("songPage.jsp");
            rd.forward(request, response);
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    @Override
    public String getServletInfo() {
        return "Short description";
    }
}
