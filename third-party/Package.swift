// swift-tools-version:6.2
// The swift-tools-version declares the minimum version of Swift required to build this package.

// Packages that are matter for Transmission for macOS.
//
// third-party/crc32c
// third-party/dht
// third-party/fmt
// third-party/libb64
// third-party/libdeflate
// third-party/libevent
// third-party/libnatpmp
// third-party/libpsl
// third-party/libutp
// third-party/miniupnp/miniupnpc
// third-party/small
// third-party/wildmat
//

import PackageDescription
import Foundation

let package = Package(
    name: "LibTransmissionDependencies",
    platforms: [.macOS(.v11)],
    products: [
// TODO: Add build phase to copy ./macos-crc32-config to ./crc32c/include/crc32c
// TODO: Add compiler flag -msse4.2 to src/crc32c_sse42.cc
        .library(name: "crc32c", targets: ["crc32c"]),
        .library(name: "dht", targets: ["dht"]),
// TODO: Add src/dummy.cpp (empty file)
        .library(name: "fmt", targets: ["fmt"]),
        .library(name: "b64", targets: ["b64"]),
        .library(name: "deflate", targets: ["deflate"]),
// TODO: Copy libevent headers properly.
// Copy/Link ./macosx-libevent-evconfig-private.h to ./libevent/include/evconfig-private.h
// Copy/Link ./macosx-libevent-event-config.h to ./libevent/include/event2/event-config.h
        .library(name: "event", targets: ["event"]),
// TODO: Fix headers layout. Add public header search path. Maybe add include folder.
// Add "include" folder.
// Copy/Link ./natpmp.h and ./getgateway.h to "include" folder.
        .library(name: "natpmp", targets: ["natpmp"]),
// TODO: Add build script.
// and Copy suffixes_dafsa.h to libpsl.
        .library(name: "psl", targets: ["psl"]),
        .library(name: "utp", targets: ["utp"]),
        .library(name: "miniupnpc", targets: ["miniupnpc"]),
// TODO: Add src/dummy.cpp (empty file)
        .library(name: "small", targets: ["small"]),
        .library(name: "wildmat", targets: ["wildmat"])
    ],
    targets: [
        .target(
            name: "crc32c",
            path: "crc32c",
            sources: [
                "src/crc32c.cc",
                "src/crc32c_arm64.cc",
                "src/crc32c_portable.cc",
                "src/crc32c_sse42.cc",
            ],
            publicHeadersPath: "include",
            cSettings: [
                .unsafeFlags(["-msse4.2"])
            ],
        ),
        .target(
            name: "dht",
            path: "dht",
            exclude: ["dht-example.c"],
            publicHeadersPath: "."
        ),
        .target(
            name: "fmt",
            path: "fmt",
            sources: [
//                "src/dummy.cc"
            ],
            publicHeadersPath: "include"
        ),
        .target(
            name: "b64",
            path: "libb64",
            sources: [
                "src/cdecode.c",
                "src/cencode.c"
            ],
            publicHeadersPath: "include"
        ),
        .target(
            name: "deflate",
            path: "libdeflate",
            sources: [
                "lib"
            ],
            publicHeadersPath: "."
        ),
        .target(
            name: "event",
            path: "libevent",
            sources: [
                "buffer.c",
                "bufferevent_filter.c",
                "bufferevent_pair.c",
                "bufferevent_ratelim.c",
                "bufferevent_sock.c",
                "bufferevent.c",
                "evutil_time.c",
                "evdns.c",
                "event.c",
                "evmap.c",
                "evthread.c",
                "evutil.c",
                "evutil_rand.c",
                "http.c",
                "kqueue.c",
                "listener.c",
                "log.c",
                "poll.c",
                "select.c",
                "signal.c",
            ],
            publicHeadersPath: "include/event2",
            cSettings: [
                .headerSearchPath("include")
            ]
        ),
        .target(
            name: "natpmp",
            path: "libnatpmp",
            sources: [
                "getgateway.c",
                "natpmp.c",
            ],
            publicHeadersPath: "include"
        ),
        .target(
            name: "psl",
            path: "libpsl",
            sources: [
                "src/lookup_string_in_fixed_set.c",
                "src/psl.c",
            ],
            publicHeadersPath: "include",
            cSettings: [
                .define("ENABLE_BUILTIN=1"),
                // for compilation only
                .define("PACKAGE_VERSION", to: "\"0\""),
            ]
        ),
        .target(
            name: "utp",
            path: "libutp",
            sources: [
                "utp_api.cpp",
                "utp_callbacks.cpp",
                "utp_hash.cpp",
                "utp_internal.cpp",
                "utp_packedsockaddr.cpp",
                "utp_utils.cpp",
            ],
            publicHeadersPath: "include/libutp",
            cSettings: [
                .define("POSIX")
            ]
        ),
        .target(
            name: "miniupnpc",
            path: "miniupnp/miniupnpc",
            sources: [
                "src/addr_is_reserved.c",
                "src/connecthostport.c",
                "src/igd_desc_parse.c",
                "src/minisoap.c",
                "src/minissdpc.c",
                "src/miniupnpc.c",
                "src/miniwget.c",
                "src/minixml.c",
                "src/portlistingparse.c",
                "src/receivedata.c",
                "src/upnpcommands.c",
                "src/upnpdev.c",
                "src/upnperrors.c",
                "src/upnpreplyparse.c",
                "miniupnpcstrings.h",
                "src/addr_is_reserved.h",
                "src/codelength.h",
                "src/connecthostport.h",
                "src/minisoap.h",
                "src/minissdpc.h",
                "src/minixml.h",
                "src/receivedata.h",
            ],
            publicHeadersPath: "include",
            cSettings: [
                .headerSearchPath("./")
            ]
        ),
        .target(
            name: "small",
            path: "small",
            sources: [
//                "src/dummy.cpp"
            ],
            publicHeadersPath: "include"
        ),
        .target(
            name: "wildmat",
            path: "wildmat",
            publicHeadersPath: "."
        ),
    ],
    cxxLanguageStandard: .cxx20
)
