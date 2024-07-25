package com.capstone.group41.remind.mate;

import org.example.Beksultan;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;

@SpringBootApplication
public class RemindMateApplication {

    public static void main(String[] args) {
        SpringApplication.run(RemindMateApplication.class, args);
        System.out.println(Beksultan.siuu);
    }
}
