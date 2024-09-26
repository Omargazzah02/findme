package com.my_back_v1.shared;

import lombok.*;
import lombok.experimental.FieldDefaults;

import java.util.Date;
@Data
@AllArgsConstructor
@NoArgsConstructor
@FieldDefaults(level = AccessLevel.PRIVATE)
@Builder

public class ErrorMessage {
    String message;
    Date timestamp;
    Integer code ;

}
