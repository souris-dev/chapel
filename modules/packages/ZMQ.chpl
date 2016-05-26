/*
 * Copyright 2004-2016 Cray Inc.
 * Other additional copyright holders may be indicated within.
 *
 * The entirety of this work is licensed under the Apache License,
 * Version 2.0 (the "License"); you may not use this file except
 * in compliance with the License.
 *
 * You may obtain a copy of the License at
 *
 *     http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

/*
  Module ZMQ: Chapel bindings for the ZeroMQ Messaging Library
*/
module ZMQ {

  require "zmq.h", "-lzmq";

  use Reflection;

  private extern var errno: c_int;

  // Types
  extern type zmq_msg_t;

  // C API
  private extern proc zmq_bind(sock: c_void_ptr, endpoint: c_string): c_int;
  private extern proc zmq_close(ctx: c_void_ptr): c_int;
  private extern proc zmq_connect(sock: c_void_ptr, endpoint: c_string): c_int;
  private extern proc zmq_ctx_new(): c_void_ptr;
  private extern proc zmq_ctx_term(ctx: c_void_ptr): c_int;
  private extern proc zmq_errno(): c_int;
  private extern proc zmq_msg_init(ref msg: zmq_msg_t): c_int;
  private extern proc zmq_msg_init_size(ref msg: zmq_msg_t,
                                        size: size_t): c_int;
  private extern proc zmq_msg_send(ref msg: zmq_msg_t, sock: c_void_ptr,
                                   flags: c_int): c_int;
  private extern proc zmq_msg_recv(ref msg: zmq_msg_t, sock: c_void_ptr,
                                   flags: c_int): c_int;
  private extern proc zmq_recv(sock: c_void_ptr, buf: c_void_ptr,
                               len: size_t, flags: c_int): c_int;
  private extern proc zmq_send(sock: c_void_ptr, buf: c_void_ptr,
                               len: size_t, flags: c_int): c_int;
  private extern proc zmq_setsockopt (sock: c_void_ptr, option_name: int,
                                      const option_value: c_void_ptr,
                                      option_len: size_t): c_int;
  private extern proc zmq_socket(ctx: c_void_ptr, socktype: c_int): c_void_ptr;
  private extern proc zmq_strerror(errnum: c_int): c_string;
  private extern proc zmq_version(major: c_ptr(c_int),
                                  minor: c_ptr(c_int),
                                  patch: c_ptr(c_int));

  // Constants
  // -- Socket Types
  private extern const ZMQ_PAIR: c_int;
  private extern const ZMQ_PUB: c_int;
  private extern const ZMQ_SUB: c_int;
  private extern const ZMQ_REQ: c_int;
  private extern const ZMQ_REP: c_int;
  private extern const ZMQ_DEALER: c_int;
  private extern const ZMQ_ROUTER: c_int;
  private extern const ZMQ_PULL: c_int;
  private extern const ZMQ_PUSH: c_int;
  private extern const ZMQ_XPUB: c_int;
  private extern const ZMQ_XSUB: c_int;
  private extern const ZMQ_STREAM: c_int;
  const PUB  = ZMQ_PUB;
  const SUB  = ZMQ_SUB;
  const REQ  = ZMQ_REQ;
  const REP  = ZMQ_REP;
  const PUSH = ZMQ_PUSH;
  const PULL = ZMQ_PULL;

  // -- Socket Options
  private extern const ZMQ_AFFINITY: c_int;
  private extern const ZMQ_IDENTITY: c_int;
  private extern const ZMQ_SUBSCRIBE: c_int;
  const SUBSCRIBE = ZMQ_SUBSCRIBE;
  private extern const ZMQ_UNSUBSCRIBE: c_int;
  private extern const ZMQ_RATE: c_int;
  private extern const ZMQ_RECOVERY_IVL: c_int;
  private extern const ZMQ_SNDBUF: c_int;
  private extern const ZMQ_RCVBUF: c_int;
  private extern const ZMQ_RCVMORE: c_int;
  private extern const ZMQ_FD: c_int;
  private extern const ZMQ_EVENTS: c_int;
  private extern const ZMQ_TYPE: c_int;
  private extern const ZMQ_LINGER: c_int;
  private extern const ZMQ_RECONNECT_IVL: c_int;
  private extern const ZMQ_BACKLOG: c_int;
  private extern const ZMQ_RECONNECT_IVL_MAX: c_int;
  private extern const ZMQ_MAXMSGSIZE: c_int;
  private extern const ZMQ_SNDHWM: c_int;
  private extern const ZMQ_RCVHWM: c_int;
  private extern const ZMQ_MULTICAST_HOPS: c_int;
  private extern const ZMQ_RCVTIMEO: c_int;
  private extern const ZMQ_SNDTIMEO: c_int;
  private extern const ZMQ_LAST_ENDPOINT: c_int;
  private extern const ZMQ_ROUTER_MANDATORY: c_int;
  private extern const ZMQ_TCP_KEEPALIVE: c_int;
  private extern const ZMQ_TCP_KEEPALIVE_CNT: c_int;
  private extern const ZMQ_TCP_KEEPALIVE_IDLE: c_int;
  private extern const ZMQ_TCP_KEEPALIVE_INTVL: c_int;
  private extern const ZMQ_TCP_ACCEPT_FILTER: c_int;
  private extern const ZMQ_IMMEDIATE: c_int;
  private extern const ZMQ_XPUB_VERBOSE: c_int;
  private extern const ZMQ_ROUTER_RAW: c_int;
  private extern const ZMQ_IPV6: c_int;
  private extern const ZMQ_MECHANISM: c_int;
  private extern const ZMQ_PLAIN_SERVER: c_int;
  private extern const ZMQ_PLAIN_USERNAME: c_int;
  private extern const ZMQ_PLAIN_PASSWORD: c_int;
  private extern const ZMQ_CURVE_SERVER: c_int;
  private extern const ZMQ_CURVE_PUBLICKEY: c_int;
  private extern const ZMQ_CURVE_SECRETKEY: c_int;
  private extern const ZMQ_CURVE_SERVERKEY: c_int;
  private extern const ZMQ_PROBE_ROUTER: c_int;
  private extern const ZMQ_REQ_CORRELATE: c_int;
  private extern const ZMQ_REQ_RELAXED: c_int;
  private extern const ZMQ_CONFLATE: c_int;
  private extern const ZMQ_ZAP_DOMAIN: c_int;

  // -- Message Options
  private extern const ZMQ_MORE: c_int;

  // -- Send/Recv Options
  private extern const ZMQ_DONTWAIT: c_int;
  private extern const ZMQ_SNDMORE: c_int;

  // -- Security Options
  private extern const ZMQ_NULL: c_int;
  private extern const ZMQ_PLAIN: c_int;
  private extern const ZMQ_CURVE: c_int;

  /*
    Query the ZMQ library version.

    :returns: An :type:`(int,int,int)` tuple of the major, minor, and patch
        version of the ZMQ library.
   */
  proc version: (int,int,int) {
    var major, minor, patch: c_int;
    zmq_version(c_ptrTo(major), c_ptrTo(minor), c_ptrTo(patch));
    return (major:int, minor:int, patch:int);
  }

  pragma "no doc"
  class RefCountBase {
    var refcnt: atomic int;

    proc incRefCount() {
      refcnt.add(1);
    }

    proc decRefCount() {
      return refcnt.fetchSub(1);
    }

    proc getRefCount() {
      return refcnt.peek();
    }

  } // class RefCountBase

  pragma "no doc"
  class ContextClass: RefCountBase {
    var ctx: c_void_ptr;

    proc ContextClass() {
      this.ctx = zmq_ctx_new();
      if this.ctx == nil {
        var errmsg = zmq_strerror(errno):string;
        halt("Error in ContextClass(): %s\n", errmsg);
      }
    }

    proc ~ContextClass() {
      var ret = zmq_ctx_term(this.ctx):int;
      if ret == -1 {
        var errmsg = zmq_strerror(errno):string;
        halt("Error in ~ContextClass(): %s\n", errmsg);
      }
    }
  } // class ContextClass

  /*
    ZeroMQ context
   */
  record Context {
    pragma "no doc"
    var classRef: ContextClass;

    proc Context() {
      acquire(new ContextClass());
    }

    pragma "no doc"
    proc ~Context() {
      release();
    }

    pragma "no doc"
    proc acquire(newRef: ContextClass) {
      classRef = newRef;
      classRef.incRefCount();
    }

    pragma "no doc"
    proc acquire() {
      classRef.incRefCount();
    }

    pragma "no doc"
    proc release() {
      var rc = classRef.decRefCount();
      if rc == 1 {
        delete classRef;
        classRef = nil;
      }
    }

    proc socket(sockType: int) {
      var sock = new Socket(this, sockType);
      return sock;
    }

  } // record Context

  pragma "no doc"
  pragma "init copy fn"
  proc chpl__initCopy(x: Context) {
    x.acquire();
    return x;
  }

  pragma "no doc"
  pragma "auto copy fn"
  proc chpl__autoCopy(x: Context) {
    x.acquire();
    return x;
  }

  proc =(ref lhs: Context, rhs: Context) {
    if lhs.classRef != nil then
      lhs.release();
    lhs.acquire(rhs.classRef);
  }

  pragma "no doc"
  class SocketClass: RefCountBase {
    var socket: c_void_ptr;

    proc SocketClass(ctx: Context, sockType: int) {
      this.socket = zmq_socket(ctx.classRef.ctx, sockType:c_int);
      if this.socket == nil {
        var errmsg = zmq_strerror(errno):string;
        halt("Error in SocketClass(): %s\n", errmsg);
      }
    }

    proc ~SocketClass() {
      var ret = zmq_close(socket):int;
      if ret == -1 {
        var errmsg = zmq_strerror(errno):string;
        halt("Error in Socket.close(): %s\n", errmsg);
      }
      socket = c_nil;
    }
  }

  /*
    ZeroMQ socket
   */
  record Socket {
    pragma "no doc"
    var classRef: SocketClass;

    pragma "no doc"
    var context: Context;

    proc Socket(ctx: Context, sockType: int) {
      context = ctx;
      acquire(new SocketClass(ctx, sockType));
    }

    pragma "no doc"
    proc ~Socket() {
      release();
    }

    pragma "no doc"
    proc acquire(newRef: SocketClass) {
      classRef = newRef;
      classRef.incRefCount();
    }

    pragma "no doc"
    proc acquire() {
      classRef.incRefCount();
    }

    pragma "no doc"
    proc release() {
      var rc = classRef.decRefCount();
      if rc == 1 {
        delete classRef;
        classRef = nil;
      }
    }

    // close
    proc close() {
      var ret = zmq_close(this.socket):int;
      if ret == -1 {
        var errmsg = zmq_strerror(errno):string;
        writef("Error in Socket.close(): %s\n", errmsg);
      }
      this.socket = c_nil;
    }

    // connect
    proc connect(endpoint: string) {
      var ret = zmq_connect(classRef.socket, endpoint.c_str());
      if ret == -1 {
        var errmsg = zmq_strerror(errno):string;
        writef("Error in Socket.connect(): %s\n", errmsg);
      }
    }

    // bind
    proc bind(endpoint: string) {
      var ret = zmq_bind(classRef.socket, endpoint.c_str());
      if ret == -1 {
        var errmsg = zmq_strerror(errno):string;
        halt("Error in Socket.bind(): ", errmsg);
      }
    }

    // setsockopt
    proc setsockopt(option: int, value: ?T) where isPODType(T) {
      var copy: T = value;
      var ret = zmq_setsockopt(classRef.socket, option:c_int,
                               c_ptrTo(copy):c_void_ptr,
                               numBytes(T)): int;
      if ret == -1 {
        var errmsg = zmq_strerror(errno):string;
        halt("Error in Socket.setsockopt(): ", errmsg);
      }
    }

    pragma "no doc"
    proc setsockopt(option: int, value: string) {
      var ret = zmq_setsockopt(classRef.socket, option:c_int,
                               value.c_str():c_void_ptr,
                               value.length:size_t): int;
      if ret == -1 {
        var errmsg = zmq_strerror(errno):string;
        halt("Error in Socket.setsockopt(): ", errmsg);
      }
    }

    /*
    pragma "no doc"
    proc setsockopt(option: int) {
      if option != SUBSCRIBE then
        halt("setsockopt()");
      var ret = zmq_setsockopt(classRef.socket, option:c_int,
                               classRef.socket, 0:size_t): int;
      if ret == -1 {
        var errmsg = zmq_strerror(errno):string;
        halt("Error in Socket.setsockopt(): ", errmsg);
      }
    }
    */

    // ZMQ serialization checker
    pragma "no doc"
    inline proc isZMQSerializable(type T) param: bool {
      return isNumericType(T) || isEnumType(T) ||
        isString(T) || isRecordType(T);
    }

    /*
      Send an object `data` on a socket.

      :arg data: The object to be sent. If `data` is an object whose type
          is not serializable by the ZMQ module, a compile-time error will be
          raised.

      :arg flags: An optional argument of the OR-able flags :const:`DONTWAIT`
          and :const:`SNDMORE`.
      :type flags: `int`
     */
    proc send(data: ?T, flags: int = 0) where !isZMQSerializable(T) {
      compilerError("Type \"", T:string, "\" is not serializable by ZMQ");
    }

    // send, strings
    pragma "no doc"
    proc send(data: string, flags: int = 0) {
      // message part 1, length
      send(data.length:uint, ZMQ_SNDMORE | flags);
      // message part 2, string
      while (-1 == zmq_send(classRef.socket, data.c_str():c_void_ptr,
                            data.length:size_t,
                            (ZMQ_DONTWAIT | flags):c_int)) {
        if errno == EAGAIN then
          chpl_task_yield();
        else {
          var errmsg = zmq_strerror(errno):string;
          halt("Error in Socket.send(%s): %s\n".format(string:string, errmsg));
        }
      }
    }

    // send, numeric types
    pragma "no doc"
    proc send(data: ?T, flags: int = 0) where isNumericType(T) {
      var temp = data;
      while (-1 == zmq_send(classRef.socket, c_ptrTo(temp):c_void_ptr,
                            numBytes(T):size_t,
                            (ZMQ_DONTWAIT | flags):c_int)) {
        if errno == EAGAIN then
          chpl_task_yield();
        else {
          var errmsg = zmq_strerror(errno):string;
          halt("Error in Socket.send(%s): %s\n".format(T:string, errmsg));
        }
      }
    }

    // send, enumerated types
    pragma "no doc"
    proc send(data: ?T, flags: int = 0) where isEnumType(T) {
      send(data:int, flags);
    }

    // send, records (of other supported things)
    pragma "no doc"
    proc send(data: ?T, flags: int = 0) where (isRecordType(T) &&
                                               (!isString(T))) {
      param N = numFields(T);
      for param i in 1..(N-1) do
        send(getField(data,i), ZMQ_SNDMORE | flags);
      send(getField(data,N), flags);
    }

    /*
      Receive an object of type :type:`T` from a socket.

      :arg T: The type of the object to be received. If :type:`T` is not
          serializable by the ZMQ module, a compile-time error will be raised.

      :arg flags: An optional argument of the flag :const:`SNDMORE`.
      :type flags: `int`

      :returns: An object of type :type:`T`
     */
    proc recv(type T, flags: int = 0): T where !isZMQSerializable(T) {
      compilerError("Type \"", T:string, "\" is not serializable by ZMQ");
    }

    // recv, strings
    pragma "no doc"
    proc recv(type T, flags: int = 0) where isString(T) {
      var len = recv(uint, flags):int;
      var buf = c_calloc(uint(8), (len+1):size_t);
      var str = new string(buff=buf, length=len, size=len+1,
                           owned=true, needToCopy=false);
      while (-1 == zmq_recv(classRef.socket, buf:c_void_ptr, len:size_t,
                            (ZMQ_DONTWAIT | flags):c_int)) {
        if errno == EAGAIN then
          chpl_task_yield();
        else {
          var errmsg = zmq_strerror(errno):string;
          halt("Error in Socket.recv(%s): %s\n".format(T:string, errmsg));
        }
      }
      return str;
    }

    // recv, numeric types
    pragma "no doc"
    proc recv(type T, flags: int = 0) where isNumericType(T) {
      var data: T;
      while (-1 == zmq_recv(classRef.socket, c_ptrTo(data):c_void_ptr,
                            numBytes(T):size_t,
                            (ZMQ_DONTWAIT | flags):c_int)) {
        if errno == EAGAIN then
          chpl_task_yield();
        else {
          var errmsg = zmq_strerror(errno):string;
          halt("Error in Socket.recv(%s): %s\n".format(T:string, errmsg));
        }
      }
      return data;
    }

    // recv, enumerated types
    pragma "no doc"
    proc recv(type T, flags: int = 0) where isEnumType(T) {
      return recv(int, flags):T;
    }

    // recv, records (of other supported things)
    pragma "no doc"
    proc recv(type T, flags: int = 0) where (isRecordType(T) && (!isString(T))) {
      var data: T;
      for param i in 1..numFields(T) do
        getFieldRef(data,i) = recv(getField(data,i).type);
      return data;
    }

  } // record Socket

  pragma "no doc"
  pragma "init copy fn"
  proc chpl__initCopy(x: Socket) {
    x.acquire();
    return x;
  }

  pragma "no doc"
  pragma "auto copy fn"
  proc chpl__autoCopy(x: Socket) {
    x.acquire();
    return x;
  }

  pragma "no doc"
  proc =(ref lhs: Socket, rhs: Socket) {
    if lhs.classRef != nil then
      lhs.release();
    lhs.acquire(rhs.classRef);
  }

} // module ZMQ
