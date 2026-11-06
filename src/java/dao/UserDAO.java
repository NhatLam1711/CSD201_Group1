/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dao;

import dto.UserDTO;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import utils.DButil;

/**
 *
 * @author DuyNQSE203196
 */
public class UserDAO {
    public UserDTO checklogin(String userId, String password) {
        Connection conn = null;
        PreparedStatement p = null;
        ResultSet rs = null;
        UserDTO user = null;
        String userID;
        String fullName;
        String pass;
        String roleID;
        try{
            conn = DButil.getConnection();
            p = conn.prepareStatement("select * from tblUsers " + "where userId=? and password=?");
            p.setString(1, userId);
            p.setString(2, password);
            rs = p.executeQuery();
            if(rs.next()){
                userID = rs.getString("UserID");
                fullName = rs.getString("fullName");
                pass = rs.getString("password");
                roleID = rs.getString("roleID");
                
                user = new UserDTO(userID, fullName, pass, roleID);
            }
            if(rs != null){
                rs.close();
            }
            if(p != null){
                p.close();
            }
            if(conn != null){
                conn.close();
            }
        } catch(SQLException e){
            System.out.println("Error access database");
        } catch(ClassNotFoundException ce){
            System.out.println("Not found class");
        }
        return user;
    }

}
