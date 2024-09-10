package com.capstone.group41.remind.mate;

import com.google.auth.oauth2.GoogleCredentials;
import com.google.firebase.FirebaseApp;
import com.google.firebase.FirebaseOptions;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;

import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.IOException;

@SpringBootApplication
public class RemindMateApplication {

    public static void main(String[] args) {

        SpringApplication.run(RemindMateApplication.class, args);
        try {
            FileInputStream serviceAccount =
                    new FileInputStream("Server/remind-mate/grpc-server/src/main/resources/config/firebase-service-acc-credentials.json");
            // ^ the file in this path is confidential and so has been kept from the repo.
            // Contact me for a copy, add it to this path and include it in remind-mate/.gitignore

            FirebaseOptions options = new FirebaseOptions.Builder()
                    .setCredentials(GoogleCredentials.fromStream(serviceAccount))
                    .build();

            FirebaseApp.initializeApp(options);
        } catch (FileNotFoundException e) {
            System.err.println("Firebase service account file not found.");
            throw new RuntimeException(e);
        } catch (IOException e) {
            throw new RuntimeException(e);
        }

    }
}
