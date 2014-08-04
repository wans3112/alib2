//
//  NVHttpConstans.h
//  NVSDK2
//
//  Created by Zhengji Tao on 11/5/13.
//  Copyright (c) 2013 Netview. All rights reserved.
//

#import <Foundation/Foundation.h>

enum NVHttpMethod {
    nvHttpGET     =   0,
    nvHttpPOST    =   1,
    nvHttpPUT     =   2,
    nvHttpDELETE  =   3
};

enum NVHttpStatus {
    nvHttpStatus_SUCCESS_OK = 200,
    nvHttpStatus_SUCCESS_CREATED = 201,
    nvHttpStatus_SUCCESS_ACCEPTED = 202,
    nvHttpStatus_SUCCESS_NON_AUTHORITATIVE = 203,
    nvHttpStatus_SUCCESS_NO_CONTENT = 204,
    nvHttpStatus_SUCCESS_RESET_CONTENT = 205,
    nvHttpStatus_SUCCESS_PARTIAL_CONTENT = 206,
    nvHttpStatus_SUCCESS_MULTI_STATUS = 207,
    nvHttpStatus_SUCCESS_TRANSFORMATION_APPLIED = 214,
    nvHttpStatus_SUCCESS_MISC_PERSISTENT_WARNING = 299,
    nvHttpStatus_CLIENT_ERROR_BAD_REQUEST = 400,
    nvHttpStatus_CLIENT_ERROR_UNAUTHORIZED = 401,
    nvHttpStatus_CLIENT_ERROR_PAYMENT_REQUIRED = 402,
    nvHttpStatus_CLIENT_ERROR_FORBIDDEN = 403,
    nvHttpStatus_CLIENT_ERROR_NOT_FOUND = 404,
    nvHttpStatus_CLIENT_ERROR_METHOD_NOT_ALLOWED = 405,
    nvHttpStatus_CLIENT_ERROR_NOT_ACCEPTABLE = 406,
    nvHttpStatus_CLIENT_ERROR_PROXY_AUTHENTIFICATION_REQUIRED = 407,
    nvHttpStatus_CLIENT_ERROR_REQUEST_TIMEOUT = 408,
    nvHttpStatus_CLIENT_ERROR_CONFLICT = 409,
    nvHttpStatus_CLIENT_ERROR_GONE = 410,
    nvHttpStatus_CLIENT_ERROR_LENGTH_REQUIRED = 411,
    nvHttpStatus_CLIENT_ERROR_PRECONDITION_FAILED = 412,
    nvHttpStatus_CLIENT_ERROR_REQUEST_ENTITY_TOO_LARGE = 413,
    nvHttpStatus_CLIENT_ERROR_REQUEST_URI_TOO_LONG = 414,
    nvHttpStatus_CLIENT_ERROR_UNSUPPORTED_MEDIA_TYPE = 415,
    nvHttpStatus_CLIENT_ERROR_REQUESTED_RANGE_NOT_SATISFIABLE = 416,
    nvHttpStatus_CLIENT_ERROR_EXPECTATION_FAILED = 417,
    nvHttpStatus_CLIENT_ERROR_UNPROCESSABLE_ENTITY = 422,
    nvHttpStatus_CLIENT_ERROR_LOCKED = 423,
    nvHttpStatus_CLIENT_ERROR_FAILED_DEPENDENCY = 424,
    nvHttpStatus_SERVER_ERROR_INTERNAL = 500,
    nvHttpStatus_SERVER_ERROR_NOT_IMPLEMENTED = 501,
    nvHttpStatus_SERVER_ERROR_BAD_GATEWAY = 502,
    nvHttpStatus_SERVER_ERROR_SERVICE_UNAVAILABLE = 503,
    nvHttpStatus_SERVER_ERROR_GATEWAY_TIMEOUT = 504,
    nvHttpStatus_SERVER_ERROR_VERSION_NOT_SUPPORTED = 505,
    nvHttpStatus_SERVER_ERROR_INSUFFICIENT_STORAGE = 507,
    };

#define NVHEADER_TOKEN_NAME @"x-nvs-token"
#define NVHEADER_UCID_NAME @"x-nvs-ucid"
#define NVHEADER_CONTENT_TYPE_NAME @"content-type"
#define NVHEADER_CONTENT_TYPE_JSON_VALUE @"application/json"
#define NVHEADER_ACCEPT_NAME @"accept"
#define NVHEADER_ACCEPT_JSON_VALUE @"application/json"

@interface NVHttpConstans : NSObject

@end
