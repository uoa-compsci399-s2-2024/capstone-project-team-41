package com.capstone.group41.remind.mate.models.entities;

import lombok.Getter;
import lombok.Setter;
import org.springframework.data.annotation.Id;
import org.springframework.data.mongodb.core.mapping.Document;
import java.time.LocalDateTime;

@Document(collection = "contacts")
public class Contact {
    @Id
    @Getter @Setter
    private String id;

    @Getter @Setter
    private String name;

    @Getter @Setter
    private RelationType relationType;

    @Getter @Setter
    private ContactMethod preferredContactMethod;

    @Getter @Setter
    private String contactDetail;

    @Getter @Setter
    private LocalDateTime birthday;

    @Getter @Setter
    private String timeZoneId;

    @Getter @Setter
    private String notes;
}
