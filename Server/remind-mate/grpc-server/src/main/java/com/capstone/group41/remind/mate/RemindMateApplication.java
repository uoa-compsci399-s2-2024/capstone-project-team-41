package com.capstone.group41.remind.mate;

import com.google.auth.oauth2.GoogleCredentials;
import com.google.firebase.FirebaseApp;
import com.google.firebase.FirebaseOptions;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.core.io.ClassPathResource;
import org.springframework.core.io.Resource;
import org.springframework.core.io.ResourceLoader;
import org.springframework.scheduling.annotation.EnableScheduling;

import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.IOException;

@SpringBootApplication
@EnableScheduling
public class RemindMateApplication {


    public static void main(String[] args) {

        SpringApplication.run(RemindMateApplication.class, args);
        try {

            ClassPathResource resource = new ClassPathResource("config/firebase-service-acc-credentials.json");

            FileInputStream serviceAccount =
                    new FileInputStream(resource.getFile().getAbsolutePath());
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
