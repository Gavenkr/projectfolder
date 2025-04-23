package com.example.demo;
import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;

import javax.sql.DataSource;
import java.sql.Connection;

import static org.assertj.core.api.Assertions.assertThat;
import static org.junit.jupiter.api.Assertions.assertDoesNotThrow;


@SpringBootTest
class DatabaseConnectionTest {

    @Autowired
    private DataSource dataSource;

    @Test
    void connectionTest() {
        assertDoesNotThrow(() -> {
            try (Connection connection = dataSource.getConnection()) {
                assertThat(connection).isNotNull();
                assertThat(connection.isValid(1)).isTrue();
            }
        });
    }
}