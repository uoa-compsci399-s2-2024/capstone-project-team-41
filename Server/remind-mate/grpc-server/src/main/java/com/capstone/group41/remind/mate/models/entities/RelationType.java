package com.capstone.group41.remind.mate.models.entities;

import lombok.Getter;
import lombok.Setter;
import org.springframework.data.annotation.Id;
import org.springframework.data.mongodb.core.mapping.Document;

@Document(collection = "RelationTypes")
public class RelationType {
    @Id
    @Getter @Setter
    private String id;

    @Getter @Setter
    private String name; // make this the id feature?
}
