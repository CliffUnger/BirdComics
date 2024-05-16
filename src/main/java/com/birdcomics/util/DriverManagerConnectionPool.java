package com.birdcomics.util;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;
import java.util.concurrent.ArrayBlockingQueue;
import java.util.concurrent.BlockingQueue;

public class DriverManagerConnectionPool {

    private static BlockingQueue<Connection> freeDbConnections;
    private static final int MAX_POOL_SIZE = 10;

    static {
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
        } catch (ClassNotFoundException e) {
            System.out.println("DB driver not found: " + e.getMessage());
        }
    }

    public DriverManagerConnectionPool() {
        freeDbConnections = new ArrayBlockingQueue<>(MAX_POOL_SIZE);
        initializeConnections();
    }

    private void initializeConnections() {
        try {
            for (int i = 0; i < MAX_POOL_SIZE; i++) {
                Connection connection = createDBConnection();
                freeDbConnections.offer(connection);
            }
        } catch (SQLException e) {
            System.out.println("Error initializing database connections: " + e.getMessage());
        }
    }

    public static Connection createDBConnection() throws SQLException {
    	Connection newConnection = null;
		String ip = "localhost";
		String port = "3306";
		String db = "shopping-cart";
		String username = "root";
		String password = "24112015";

		newConnection = DriverManager.getConnection("jdbc:mysql://"+ ip+":"+ port+"/"+db+"?useUnicode=true&useJDBCCompliantTimezoneShift=true&useLegacyDatetimeCode=false&serverTimezone=UTC", username, password);
		return newConnection;
	}

    public Connection getConnection() throws SQLException {
        Connection connection = freeDbConnections.poll();
        if (connection == null || connection.isClosed()) {
            connection = createDBConnection();
        }
        return connection;
    }

    public static void closeConnection(Connection connection) {
        if (connection != null && !freeDbConnections.contains(connection)) {
            try {
                freeDbConnections.offer(connection);
            } catch (IllegalStateException e) {
                // Queue full, close the connection
                try {
                    connection.close();
                } catch (SQLException ex) {
                    System.out.println("Error closing connection: " + ex.getMessage());
                }
            }
        }
    }
}