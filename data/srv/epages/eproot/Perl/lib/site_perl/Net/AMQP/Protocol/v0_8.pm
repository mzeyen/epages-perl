package Net::AMQP::Protocol::v0_8;

=pod

=head1 NAME

Net::AMQP::Protocol::v0_8 - AMQP v0.8 (de)serialization and representation 

=head1 SYNOPSIS

  use Net::AMQP::Protocol::v0_8;
  
  ...

  my @frames = Net::AMQP->parse_raw_frames(\$input);
  
  ...

  my $frame = Net::AMQP::Frame::Method->new(
      channel => 0,
      method_frame => Net::AMQP::Protocol::Connection::StartOk->new(
          client_properties => { ... },
          mechanism         => 'AMQPLAIN',
          locale            => 'en_US',
          response          => {
              LOGIN    => 'guest',
              PASSWORD => 'guest',
          },
      ),
  );

  print OUT $frame->to_raw_frame();

=head1 DESCRIPTION

This module implements the frame (de)serialization and representation of the Advanced Message Queue Protocol (http://www.amqp.org/) version 0.8.   

It is to be used in conjunction with client or server software that does the actual TCP/IP communication.

=cut

use strict;
use warnings;

use Net::AMQP;

sub import {
    return if defined $Net::AMQP::Protocol::VERSION_MAJOR; # do not load twice
    load();
}

sub load {
    Net::AMQP::Protocol->load_xml_spec(undef, as_string_ref());
}

sub as_string_ref {
    local $/ = undef;
    my $str = <DATA>;
    return \$str;
}

1;


=pod

=head1 PROTOCOL CLASSES

=head2 Net::AMQP::Protocol::Connection::Start

This class implements the class B<Connection> method B<Start>, which is a synchronous method.

This method starts the connection negotiation process by telling the client the protocol version that the server proposes, along with a list of security mechanisms which the client can use for authentication. 

Each of the following represents a field in the specification. These are the optional arguments to B<new()> and are also read/write accessors:

=over 4

=item I<version_major> (type: octet)

Protocol major version 

The protocol major version that the server agrees to use, which cannot be higher than the client's major version. 

=item I<version_minor> (type: octet)

Protocol major version 

The protocol minor version that the server agrees to use, which cannot be higher than the client's minor version. 

=item I<server_properties> (type: table)

Server properties 

=item I<mechanisms> (type: longstr)

Available security mechanisms 

A list of the security mechanisms that the server supports, delimited by spaces. Currently ASL supports these mechanisms: PLAIN. 

=item I<locales> (type: longstr)

Available message locales 

A list of the message locales that the server supports, delimited by spaces. The locale defines the language in which the server will send reply texts. 

=back

=head2 Net::AMQP::Protocol::Connection::StartOk

This class implements the class B<Connection> method B<StartOk>, which is a synchronous method.

This method selects a SASL security mechanism. ASL uses SASL (RFC2222) to negotiate authentication and encryption. 

Each of the following represents a field in the specification. These are the optional arguments to B<new()> and are also read/write accessors:

=over 4

=item I<client_properties> (type: table)

Client properties 

=item I<mechanism> (type: shortstr)

Selected security mechanism 

A single security mechanisms selected by the client, which must be one of those specified by the server. 

=item I<response> (type: longstr)

Security response data 

A block of opaque data passed to the security mechanism. The contents of this data are defined by the SASL security mechanism. For the PLAIN security mechanism this is defined as a field table holding two fields, LOGIN and PASSWORD. 

=item I<locale> (type: shortstr)

Selected message locale 

A single message local selected by the client, which must be one of those specified by the server. 

=back

=head2 Net::AMQP::Protocol::Connection::Secure

This class implements the class B<Connection> method B<Secure>, which is a synchronous method.

The SASL protocol works by exchanging challenges and responses until both peers have received sufficient information to authenticate each other. This method challenges the client to provide more information. 

Each of the following represents a field in the specification. These are the optional arguments to B<new()> and are also read/write accessors:

=over 4

=item I<challenge> (type: longstr)

Security challenge data 

Challenge information, a block of opaque binary data passed to the security mechanism. 

=back

=head2 Net::AMQP::Protocol::Connection::SecureOk

This class implements the class B<Connection> method B<SecureOk>, which is a synchronous method.

This method attempts to authenticate, passing a block of SASL data for the security mechanism at the server side. 

Each of the following represents a field in the specification. These are the optional arguments to B<new()> and are also read/write accessors:

=over 4

=item I<response> (type: longstr)

Security response data 

A block of opaque data passed to the security mechanism. The contents of this data are defined by the SASL security mechanism. 

=back

=head2 Net::AMQP::Protocol::Connection::Tune

This class implements the class B<Connection> method B<Tune>, which is a synchronous method.

This method proposes a set of connection configuration values to the client. The client can accept and/or adjust these. 

Each of the following represents a field in the specification. These are the optional arguments to B<new()> and are also read/write accessors:

=over 4

=item I<channel_max> (type: short)

Proposed maximum channels 

The maximum total number of channels that the server allows per connection. Zero means that the server does not impose a fixed limit, but the number of allowed channels may be limited by available server resources. 

=item I<frame_max> (type: long)

Proposed maximum frame size 

The largest frame size that the server proposes for the connection. The client can negotiate a lower value. Zero means that the server does not impose any specific limit but may reject very large frames if it cannot allocate resources for them. 

=item I<heartbeat> (type: short)

Desired heartbeat delay 

The delay, in seconds, of the connection heartbeat that the server wants. Zero means the server does not want a heartbeat. 

=back

=head2 Net::AMQP::Protocol::Connection::TuneOk

This class implements the class B<Connection> method B<TuneOk>, which is a synchronous method.

This method sends the client's connection tuning parameters to the server. Certain fields are negotiated, others provide capability information. 

Each of the following represents a field in the specification. These are the optional arguments to B<new()> and are also read/write accessors:

=over 4

=item I<channel_max> (type: short)

Negotiated maximum channels 

The maximum total number of channels that the client will use per connection. May not be higher than the value specified by the server. 

=item I<frame_max> (type: long)

Negotiated maximum frame size 

The largest frame size that the client and server will use for the connection. Zero means that the client does not impose any specific limit but may reject very large frames if it cannot allocate resources for them. Note that the frame-max limit applies principally to content frames, where large contents can be broken into frames of arbitrary size. 

=item I<heartbeat> (type: short)

Desired heartbeat delay 

The delay, in seconds, of the connection heartbeat that the client wants. Zero means the client does not want a heartbeat. 

=back

=head2 Net::AMQP::Protocol::Connection::Open

This class implements the class B<Connection> method B<Open>, which is a synchronous method.

This method opens a connection to a virtual host, which is a collection of resources, and acts to separate multiple application domains within a server. 

Each of the following represents a field in the specification. These are the optional arguments to B<new()> and are also read/write accessors:

=over 4

=item I<virtual_host> (type: shortstr)

Virtual host name 

The name of the virtual host to work with. 

=item I<capabilities> (type: shortstr)

Required capabilities 

The client may specify a number of capability names, delimited by spaces. The server can use this string to how to process the client's connection request. 

=item I<insist> (type: bit)

Insist on connecting to server 

In a configuration with multiple load-sharing servers, the server may respond to a Connection.Open method with a Connection.Redirect. The insist option tells the server that the client is insisting on a connection to the specified server. 

=back

=head2 Net::AMQP::Protocol::Connection::OpenOk

This class implements the class B<Connection> method B<OpenOk>, which is a synchronous method.

This method signals to the client that the connection is ready for use. 

Each of the following represents a field in the specification. These are the optional arguments to B<new()> and are also read/write accessors:

=over 4

=item I<known_hosts> (type: shortstr)

=back

=head2 Net::AMQP::Protocol::Connection::Redirect

This class implements the class B<Connection> method B<Redirect>, which is a synchronous method.

This method redirects the client to another server, based on the requested virtual host and/or capabilities. 

Each of the following represents a field in the specification. These are the optional arguments to B<new()> and are also read/write accessors:

=over 4

=item I<host> (type: shortstr)

Server to connect to 

Specifies the server to connect to. This is an IP address or a DNS name, optionally followed by a colon and a port number. If no port number is specified, the client should use the default port number for the protocol. 

=item I<known_hosts> (type: shortstr)

=back

=head2 Net::AMQP::Protocol::Connection::Close

This class implements the class B<Connection> method B<Close>, which is a synchronous method.

This method indicates that the sender wants to close the connection. This may be due to internal conditions (e.g. a forced shut-down) or due to an error handling a specific method, i.e. an exception. When a close is due to an exception, the sender provides the class and method id of the method which caused the exception. 

Each of the following represents a field in the specification. These are the optional arguments to B<new()> and are also read/write accessors:

=over 4

=item I<reply_code> (type: short)

=item I<reply_text> (type: shortstr)

=item I<class_id> (type: short)

Failing method class 

When the close is provoked by a method exception, this is the class of the method. 

=item I<method_id> (type: short)

Failing method ID 

When the close is provoked by a method exception, this is the ID of the method. 

=back

=head2 Net::AMQP::Protocol::Connection::CloseOk

This class implements the class B<Connection> method B<CloseOk>, which is a synchronous method.

This method confirms a Connection.Close method and tells the recipient that it is safe to release resources for the connection and close the socket. 

This class has no fields nor accessors.

=head2 Net::AMQP::Protocol::Channel::Open

This class implements the class B<Channel> method B<Open>, which is a synchronous method.

This method opens a virtual connection (a channel). 

Each of the following represents a field in the specification. These are the optional arguments to B<new()> and are also read/write accessors:

=over 4

=item I<out_of_band> (type: shortstr)

Out-of-band settings 

Configures out-of-band transfers on this channel. The syntax and meaning of this field will be formally defined at a later date. 

=back

=head2 Net::AMQP::Protocol::Channel::OpenOk

This class implements the class B<Channel> method B<OpenOk>, which is a synchronous method.

This method signals to the client that the channel is ready for use. 

This class has no fields nor accessors.

=head2 Net::AMQP::Protocol::Channel::Flow

This class implements the class B<Channel> method B<Flow>, which is a synchronous method.

This method asks the peer to pause or restart the flow of content data. This is a simple flow-control mechanism that a peer can use to avoid oveflowing its queues or otherwise finding itself receiving more messages than it can process. Note that this method is not intended for window control. The peer that receives a request to stop sending content should finish sending the current content, if any, and then wait until it receives a Flow restart method. 

Each of the following represents a field in the specification. These are the optional arguments to B<new()> and are also read/write accessors:

=over 4

=item I<active> (type: bit)

Start/stop content frames 

If 1, the peer starts sending content frames. If 0, the peer stops sending content frames. 

=back

=head2 Net::AMQP::Protocol::Channel::FlowOk

This class implements the class B<Channel> method B<FlowOk>, which is an asynchronous method.

Confirms to the peer that a flow command was received and processed. 

Each of the following represents a field in the specification. These are the optional arguments to B<new()> and are also read/write accessors:

=over 4

=item I<active> (type: bit)

Current flow setting 

Confirms the setting of the processed flow method: 1 means the peer will start sending or continue to send content frames; 0 means it will not. 

=back

=head2 Net::AMQP::Protocol::Channel::Alert

This class implements the class B<Channel> method B<Alert>, which is an asynchronous method.

This method allows the server to send a non-fatal warning to the client. This is used for methods that are normally asynchronous and thus do not have confirmations, and for which the server may detect errors that need to be reported. Fatal errors are handled as channel or connection exceptions; non-fatal errors are sent through this method. 

Each of the following represents a field in the specification. These are the optional arguments to B<new()> and are also read/write accessors:

=over 4

=item I<reply_code> (type: short)

=item I<reply_text> (type: shortstr)

=item I<details> (type: table)

Detailed information for warning 

A set of fields that provide more information about the problem. The meaning of these fields are defined on a per-reply-code basis (TO BE DEFINED). 

=back

=head2 Net::AMQP::Protocol::Channel::Close

This class implements the class B<Channel> method B<Close>, which is a synchronous method.

This method indicates that the sender wants to close the channel. This may be due to internal conditions (e.g. a forced shut-down) or due to an error handling a specific method, i.e. an exception. When a close is due to an exception, the sender provides the class and method id of the method which caused the exception. 

Each of the following represents a field in the specification. These are the optional arguments to B<new()> and are also read/write accessors:

=over 4

=item I<reply_code> (type: short)

=item I<reply_text> (type: shortstr)

=item I<class_id> (type: short)

Failing method class 

When the close is provoked by a method exception, this is the class of the method. 

=item I<method_id> (type: short)

Failing method ID 

When the close is provoked by a method exception, this is the ID of the method. 

=back

=head2 Net::AMQP::Protocol::Channel::CloseOk

This class implements the class B<Channel> method B<CloseOk>, which is a synchronous method.

This method confirms a Channel.Close method and tells the recipient that it is safe to release resources for the channel and close the socket. 

This class has no fields nor accessors.

=head2 Net::AMQP::Protocol::Access::Request

This class implements the class B<Access> method B<Request>, which is a synchronous method.

This method requests an access ticket for an access realm. The server responds by granting the access ticket. If the client does not have access rights to the requested realm this causes a connection exception. Access tickets are a per-channel resource. 

Each of the following represents a field in the specification. These are the optional arguments to B<new()> and are also read/write accessors:

=over 4

=item I<realm> (type: shortstr)

Name of requested realm 

=item I<exclusive> (type: bit)

Request exclusive access 

Request exclusive access to the realm. If the server cannot grant this - because there are other active tickets for the realm - it raises a channel exception. 

=item I<passive> (type: bit)

Request passive access 

Request message passive access to the specified access realm. Passive access lets a client get information about resources in the realm but not to make any changes to them. 

=item I<active> (type: bit)

Request active access 

Request message active access to the specified access realm. Acvtive access lets a client get create and delete resources in the realm. 

=item I<write> (type: bit)

Request write access 

Request write access to the specified access realm. Write access lets a client publish messages to all exchanges in the realm. 

=item I<read> (type: bit)

Request read access 

Request read access to the specified access realm. Read access lets a client consume messages from queues in the realm. 

=back

=head2 Net::AMQP::Protocol::Access::RequestOk

This class implements the class B<Access> method B<RequestOk>, which is a synchronous method.

This method provides the client with an access ticket. The access ticket is valid within the current channel and for the lifespan of the channel. 

Each of the following represents a field in the specification. These are the optional arguments to B<new()> and are also read/write accessors:

=over 4

=item I<ticket> (type: short)

=back

=head2 Net::AMQP::Protocol::Exchange::Declare

This class implements the class B<Exchange> method B<Declare>, which is a synchronous method.

This method creates an exchange if it does not already exist, and if the exchange exists, verifies that it is of the correct and expected class. 

Each of the following represents a field in the specification. These are the optional arguments to B<new()> and are also read/write accessors:

=over 4

=item I<ticket> (type: short)

When a client defines a new exchange, this belongs to the access realm of the ticket used. All further work done with that exchange must be done with an access ticket for the same realm. 

=item I<exchange> (type: shortstr)

=item I<type> (type: shortstr)

Exchange type 

Each exchange belongs to one of a set of exchange types implemented by the server. The exchange types define the functionality of the exchange - i.e. how messages are routed through it. It is not valid or meaningful to attempt to change the type of an existing exchange. 

=item I<passive> (type: bit)

Do not create exchange 

If set, the server will not create the exchange. The client can use this to check whether an exchange exists without modifying the server state. 

=item I<durable> (type: bit)

Request a durable exchange 

If set when creating a new exchange, the exchange will be marked as durable. Durable exchanges remain active when a server restarts. Non-durable exchanges (transient exchanges) are purged if/when a server restarts. 

=item I<auto_delete> (type: bit)

Auto-delete when unused 

If set, the exchange is deleted when all queues have finished using it. 

=item I<internal> (type: bit)

Create internal exchange 

If set, the exchange may not be used directly by publishers, but only when bound to other exchanges. Internal exchanges are used to construct wiring that is not visible to applications. 

=item I<nowait> (type: bit)

Do not send a reply method 

If set, the server will not respond to the method. The client should not wait for a reply method. If the server could not complete the method it will raise a channel or connection exception. 

=item I<arguments> (type: table)

Arguments for declaration 

A set of arguments for the declaration. The syntax and semantics of these arguments depends on the server implementation. This field is ignored if passive is 1. 

=back

=head2 Net::AMQP::Protocol::Exchange::DeclareOk

This class implements the class B<Exchange> method B<DeclareOk>, which is a synchronous method.

This method confirms a Declare method and confirms the name of the exchange, essential for automatically-named exchanges. 

This class has no fields nor accessors.

=head2 Net::AMQP::Protocol::Exchange::Delete

This class implements the class B<Exchange> method B<Delete>, which is a synchronous method.

This method deletes an exchange. When an exchange is deleted all queue bindings on the exchange are cancelled. 

Each of the following represents a field in the specification. These are the optional arguments to B<new()> and are also read/write accessors:

=over 4

=item I<ticket> (type: short)

=item I<exchange> (type: shortstr)

=item I<if_unused> (type: bit)

Delete only if unused 

If set, the server will only delete the exchange if it has no queue bindings. If the exchange has queue bindings the server does not delete it but raises a channel exception instead. 

=item I<nowait> (type: bit)

Do not send a reply method 

If set, the server will not respond to the method. The client should not wait for a reply method. If the server could not complete the method it will raise a channel or connection exception. 

=back

=head2 Net::AMQP::Protocol::Exchange::DeleteOk

This class implements the class B<Exchange> method B<DeleteOk>, which is a synchronous method.

This method confirms the deletion of an exchange. 

This class has no fields nor accessors.

=head2 Net::AMQP::Protocol::Queue::Declare

This class implements the class B<Queue> method B<Declare>, which is a synchronous method.

This method creates or checks a queue. When creating a new queue the client can specify various properties that control the durability of the queue and its contents, and the level of sharing for the queue. 

Each of the following represents a field in the specification. These are the optional arguments to B<new()> and are also read/write accessors:

=over 4

=item I<ticket> (type: short)

When a client defines a new queue, this belongs to the access realm of the ticket used. All further work done with that queue must be done with an access ticket for the same realm. 

The client provides a valid access ticket giving "active" access to the realm in which the queue exists or will be created, or "passive" access if the if-exists flag is set. 

=item I<queue> (type: shortstr)

=item I<passive> (type: bit)

Do not create queue 

If set, the server will not create the queue. The client can use this to check whether a queue exists without modifying the server state. 

=item I<durable> (type: bit)

Request a durable queue 

If set when creating a new queue, the queue will be marked as durable. Durable queues remain active when a server restarts. Non-durable queues (transient queues) are purged if/when a server restarts. Note that durable queues do not necessarily hold persistent messages, although it does not make sense to send persistent messages to a transient queue. 

=item I<exclusive> (type: bit)

Request an exclusive queue 

Exclusive queues may only be consumed from by the current connection. Setting the 'exclusive' flag always implies 'auto-delete'. 

=item I<auto_delete> (type: bit)

Auto-delete queue when unused 

If set, the queue is deleted when all consumers have finished using it. Last consumer can be cancelled either explicitly or because its channel is closed. If there was no consumer ever on the queue, it won't be deleted. 

=item I<nowait> (type: bit)

Do not send a reply method 

If set, the server will not respond to the method. The client should not wait for a reply method. If the server could not complete the method it will raise a channel or connection exception. 

=item I<arguments> (type: table)

Arguments for declaration 

A set of arguments for the declaration. The syntax and semantics of these arguments depends on the server implementation. This field is ignored if passive is 1. 

=back

=head2 Net::AMQP::Protocol::Queue::DeclareOk

This class implements the class B<Queue> method B<DeclareOk>, which is a synchronous method.

This method confirms a Declare method and confirms the name of the queue, essential for automatically-named queues. 

Each of the following represents a field in the specification. These are the optional arguments to B<new()> and are also read/write accessors:

=over 4

=item I<queue> (type: shortstr)

Reports the name of the queue. If the server generated a queue name, this field contains that name. 

=item I<message_count> (type: long)

Number of messages in queue 

Reports the number of messages in the queue, which will be zero for newly-created queues. 

=item I<consumer_count> (type: long)

Number of consumers 

Reports the number of active consumers for the queue. Note that consumers can suspend activity (Channel.Flow) in which case they do not appear in this count. 

=back

=head2 Net::AMQP::Protocol::Queue::Bind

This class implements the class B<Queue> method B<Bind>, which is a synchronous method.

This method binds a queue to an exchange. Until a queue is bound it will not receive any messages. In a classic messaging model, store-and-forward queues are bound to a dest exchange and subscription queues are bound to a dest_wild exchange. 

Each of the following represents a field in the specification. These are the optional arguments to B<new()> and are also read/write accessors:

=over 4

=item I<ticket> (type: short)

The client provides a valid access ticket giving "active" access rights to the queue's access realm. 

=item I<queue> (type: shortstr)

Specifies the name of the queue to bind. If the queue name is empty, refers to the current queue for the channel, which is the last declared queue. 

=item I<exchange> (type: shortstr)

The name of the exchange to bind to. 

=item I<routing_key> (type: shortstr)

Message routing key 

Specifies the routing key for the binding. The routing key is used for routing messages depending on the exchange configuration. Not all exchanges use a routing key - refer to the specific exchange documentation. If the routing key is empty and the queue name is empty, the routing key will be the current queue for the channel, which is the last declared queue. 

=item I<nowait> (type: bit)

Do not send a reply method 

If set, the server will not respond to the method. The client should not wait for a reply method. If the server could not complete the method it will raise a channel or connection exception. 

=item I<arguments> (type: table)

Arguments for binding 

A set of arguments for the binding. The syntax and semantics of these arguments depends on the exchange class. 

=back

=head2 Net::AMQP::Protocol::Queue::BindOk

This class implements the class B<Queue> method B<BindOk>, which is a synchronous method.

This method confirms that the bind was successful. 

This class has no fields nor accessors.

=head2 Net::AMQP::Protocol::Queue::Purge

This class implements the class B<Queue> method B<Purge>, which is a synchronous method.

This method removes all messages from a queue. It does not cancel consumers. Purged messages are deleted without any formal "undo" mechanism. 

Each of the following represents a field in the specification. These are the optional arguments to B<new()> and are also read/write accessors:

=over 4

=item I<ticket> (type: short)

The access ticket must be for the access realm that holds the queue. 

=item I<queue> (type: shortstr)

Specifies the name of the queue to purge. If the queue name is empty, refers to the current queue for the channel, which is the last declared queue. 

=item I<nowait> (type: bit)

Do not send a reply method 

If set, the server will not respond to the method. The client should not wait for a reply method. If the server could not complete the method it will raise a channel or connection exception. 

=back

=head2 Net::AMQP::Protocol::Queue::PurgeOk

This class implements the class B<Queue> method B<PurgeOk>, which is a synchronous method.

This method confirms the purge of a queue. 

Each of the following represents a field in the specification. These are the optional arguments to B<new()> and are also read/write accessors:

=over 4

=item I<message_count> (type: long)

Number of messages purged 

Reports the number of messages purged. 

=back

=head2 Net::AMQP::Protocol::Queue::Delete

This class implements the class B<Queue> method B<Delete>, which is a synchronous method.

This method deletes a queue. When a queue is deleted any pending messages are sent to a dead-letter queue if this is defined in the server configuration, and all consumers on the queue are cancelled. 

Each of the following represents a field in the specification. These are the optional arguments to B<new()> and are also read/write accessors:

=over 4

=item I<ticket> (type: short)

The client provides a valid access ticket giving "active" access rights to the queue's access realm. 

=item I<queue> (type: shortstr)

Specifies the name of the queue to delete. If the queue name is empty, refers to the current queue for the channel, which is the last declared queue. 

=item I<if_unused> (type: bit)

Delete only if unused 

If set, the server will only delete the queue if it has no consumers. If the queue has consumers the server does does not delete it but raises a channel exception instead. 

=item I<if_empty> (type: bit)

Delete only if empty 

If set, the server will only delete the queue if it has no messages. If the queue is not empty the server raises a channel exception. 

=item I<nowait> (type: bit)

Do not send a reply method 

If set, the server will not respond to the method. The client should not wait for a reply method. If the server could not complete the method it will raise a channel or connection exception. 

=back

=head2 Net::AMQP::Protocol::Queue::DeleteOk

This class implements the class B<Queue> method B<DeleteOk>, which is a synchronous method.

This method confirms the deletion of a queue. 

Each of the following represents a field in the specification. These are the optional arguments to B<new()> and are also read/write accessors:

=over 4

=item I<message_count> (type: long)

Number of messages purged 

Reports the number of messages purged. 

=back

=head2 Net::AMQP::Protocol::Basic::Qos

This class implements the class B<Basic> method B<Qos>, which is a synchronous method.

This method requests a specific quality of service. The QoS can be specified for the current channel or for all channels on the connection. The particular properties and semantics of a qos method always depend on the content class semantics. Though the qos method could in principle apply to both peers, it is currently meaningful only for the server. 

Each of the following represents a field in the specification. These are the optional arguments to B<new()> and are also read/write accessors:

=over 4

=item I<prefetch_size> (type: long)

Prefetch window in octets 

The client can request that messages be sent in advance so that when the client finishes processing a message, the following message is already held locally, rather than needing to be sent down the channel. Prefetching gives a performance improvement. This field specifies the prefetch window size in octets. The server will send a message in advance if it is equal to or smaller in size than the available prefetch size (and also falls into other prefetch limits). May be set to zero, meaning "no specific limit", although other prefetch limits may still apply. The prefetch-size is ignored if the no-ack option is set. 

=item I<prefetch_count> (type: short)

Prefetch window in messages 

Specifies a prefetch window in terms of whole messages. This field may be used in combination with the prefetch-size field; a message will only be sent in advance if both prefetch windows (and those at the channel and connection level) allow it. The prefetch-count is ignored if the no-ack option is set. 

=item I<global> (type: bit)

Apply to entire connection 

By default the QoS settings apply to the current channel only. If this field is set, they are applied to the entire connection. 

=back

=head2 Net::AMQP::Protocol::Basic::QosOk

This class implements the class B<Basic> method B<QosOk>, which is a synchronous method.

This method tells the client that the requested QoS levels could be handled by the server. The requested QoS applies to all active consumers until a new QoS is defined. 

This class has no fields nor accessors.

=head2 Net::AMQP::Protocol::Basic::Consume

This class implements the class B<Basic> method B<Consume>, which is a synchronous method.

This method asks the server to start a "consumer", which is a transient request for messages from a specific queue. Consumers last as long as the channel they were created on, or until the client cancels them. 

Each of the following represents a field in the specification. These are the optional arguments to B<new()> and are also read/write accessors:

=over 4

=item I<ticket> (type: short)

=item I<queue> (type: shortstr)

Specifies the name of the queue to consume from. If the queue name is null, refers to the current queue for the channel, which is the last declared queue. 

=item I<consumer_tag> (type: shortstr)

Specifies the identifier for the consumer. The consumer tag is local to a connection, so two clients can use the same consumer tags. If this field is empty the server will generate a unique tag. 

=item I<no_local> (type: bit)

=item I<no_ack> (type: bit)

=item I<exclusive> (type: bit)

Request exclusive access 

Request exclusive consumer access, meaning only this consumer can access the queue. 

=item I<nowait> (type: bit)

Do not send a reply method 

If set, the server will not respond to the method. The client should not wait for a reply method. If the server could not complete the method it will raise a channel or connection exception. 

=back

=head2 Net::AMQP::Protocol::Basic::ConsumeOk

This class implements the class B<Basic> method B<ConsumeOk>, which is a synchronous method.

The server provides the client with a consumer tag, which is used by the client for methods called on the consumer at a later stage. 

Each of the following represents a field in the specification. These are the optional arguments to B<new()> and are also read/write accessors:

=over 4

=item I<consumer_tag> (type: shortstr)

Holds the consumer tag specified by the client or provided by the server. 

=back

=head2 Net::AMQP::Protocol::Basic::Cancel

This class implements the class B<Basic> method B<Cancel>, which is a synchronous method.

This method cancels a consumer. This does not affect already delivered messages, but it does mean the server will not send any more messages for that consumer. The client may receive an abitrary number of messages in between sending the cancel method and receiving the cancel-ok reply. 

Each of the following represents a field in the specification. These are the optional arguments to B<new()> and are also read/write accessors:

=over 4

=item I<consumer_tag> (type: shortstr)

=item I<nowait> (type: bit)

Do not send a reply method 

If set, the server will not respond to the method. The client should not wait for a reply method. If the server could not complete the method it will raise a channel or connection exception. 

=back

=head2 Net::AMQP::Protocol::Basic::CancelOk

This class implements the class B<Basic> method B<CancelOk>, which is a synchronous method.

This method confirms that the cancellation was completed. 

Each of the following represents a field in the specification. These are the optional arguments to B<new()> and are also read/write accessors:

=over 4

=item I<consumer_tag> (type: shortstr)

=back

=head2 Net::AMQP::Protocol::Basic::Publish

This class implements the class B<Basic> method B<Publish>, which is an asynchronous method.

This method publishes a message to a specific exchange. The message will be routed to queues as defined by the exchange configuration and distributed to any active consumers when the transaction, if any, is committed. 

Each of the following represents a field in the specification. These are the optional arguments to B<new()> and are also read/write accessors:

=over 4

=item I<ticket> (type: short)

=item I<exchange> (type: shortstr)

Specifies the name of the exchange to publish to. The exchange name can be empty, meaning the default exchange. If the exchange name is specified, and that exchange does not exist, the server will raise a channel exception. 

=item I<routing_key> (type: shortstr)

Message routing key 

Specifies the routing key for the message. The routing key is used for routing messages depending on the exchange configuration. 

=item I<mandatory> (type: bit)

Indicate mandatory routing 

This flag tells the server how to react if the message cannot be routed to a queue. If this flag is set, the server will return an unroutable message with a Return method. If this flag is zero, the server silently drops the message. 

=item I<immediate> (type: bit)

Request immediate delivery 

This flag tells the server how to react if the message cannot be routed to a queue consumer immediately. If this flag is set, the server will return an undeliverable message with a Return method. If this flag is zero, the server will queue the message, but with no guarantee that it will ever be consumed. 

=back

=head2 Net::AMQP::Protocol::Basic::Return

This class implements the class B<Basic> method B<Return>, which is an asynchronous method.

This method returns an undeliverable message that was published with the "immediate" flag set, or an unroutable message published with the "mandatory" flag set. The reply code and text provide information about the reason that the message was undeliverable. 

Each of the following represents a field in the specification. These are the optional arguments to B<new()> and are also read/write accessors:

=over 4

=item I<reply_code> (type: short)

=item I<reply_text> (type: shortstr)

=item I<exchange> (type: shortstr)

Specifies the name of the exchange that the message was originally published to. 

=item I<routing_key> (type: shortstr)

Message routing key 

Specifies the routing key name specified when the message was published. 

=back

=head2 Net::AMQP::Protocol::Basic::Deliver

This class implements the class B<Basic> method B<Deliver>, which is an asynchronous method.

This method delivers a message to the client, via a consumer. In the asynchronous message delivery model, the client starts a consumer using the Consume method, then the server responds with Deliver methods as and when messages arrive for that consumer. 

Each of the following represents a field in the specification. These are the optional arguments to B<new()> and are also read/write accessors:

=over 4

=item I<consumer_tag> (type: shortstr)

=item I<delivery_tag> (type: longlong)

=item I<redelivered> (type: bit)

=item I<exchange> (type: shortstr)

Specifies the name of the exchange that the message was originally published to. 

=item I<routing_key> (type: shortstr)

Message routing key 

Specifies the routing key name specified when the message was published. 

=back

=head2 Net::AMQP::Protocol::Basic::Get

This class implements the class B<Basic> method B<Get>, which is a synchronous method.

This method provides a direct access to the messages in a queue using a synchronous dialogue that is designed for specific types of application where synchronous functionality is more important than performance. 

Each of the following represents a field in the specification. These are the optional arguments to B<new()> and are also read/write accessors:

=over 4

=item I<ticket> (type: short)

=item I<queue> (type: shortstr)

Specifies the name of the queue to consume from. If the queue name is null, refers to the current queue for the channel, which is the last declared queue. 

=item I<no_ack> (type: bit)

=back

=head2 Net::AMQP::Protocol::Basic::GetOk

This class implements the class B<Basic> method B<GetOk>, which is a synchronous method.

This method delivers a message to the client following a get method. A message delivered by 'get-ok' must be acknowledged unless the no-ack option was set in the get method. 

Each of the following represents a field in the specification. These are the optional arguments to B<new()> and are also read/write accessors:

=over 4

=item I<delivery_tag> (type: longlong)

=item I<redelivered> (type: bit)

=item I<exchange> (type: shortstr)

Specifies the name of the exchange that the message was originally published to. If empty, the message was published to the default exchange. 

=item I<routing_key> (type: shortstr)

Message routing key 

Specifies the routing key name specified when the message was published. 

=item I<message_count> (type: long)

Number of messages pending 

This field reports the number of messages pending on the queue, excluding the message being delivered. Note that this figure is indicative, not reliable, and can change arbitrarily as messages are added to the queue and removed by other clients. 

=back

=head2 Net::AMQP::Protocol::Basic::GetEmpty

This class implements the class B<Basic> method B<GetEmpty>, which is a synchronous method.

This method tells the client that the queue has no messages available for the client. 

Each of the following represents a field in the specification. These are the optional arguments to B<new()> and are also read/write accessors:

=over 4

=item I<cluster_id> (type: shortstr)

Cluster id 

For use by cluster applications, should not be used by client applications. 

=back

=head2 Net::AMQP::Protocol::Basic::Ack

This class implements the class B<Basic> method B<Ack>, which is an asynchronous method.

This method acknowledges one or more messages delivered via the Deliver or Get-Ok methods. The client can ask to confirm a single message or a set of messages up to and including a specific message. 

Each of the following represents a field in the specification. These are the optional arguments to B<new()> and are also read/write accessors:

=over 4

=item I<delivery_tag> (type: longlong)

=item I<multiple> (type: bit)

Acknowledge multiple messages 

If set to 1, the delivery tag is treated as "up to and including", so that the client can acknowledge multiple messages with a single method. If set to zero, the delivery tag refers to a single message. If the multiple field is 1, and the delivery tag is zero, tells the server to acknowledge all outstanding mesages. 

=back

=head2 Net::AMQP::Protocol::Basic::Reject

This class implements the class B<Basic> method B<Reject>, which is an asynchronous method.

This method allows a client to reject a message. It can be used to interrupt and cancel large incoming messages, or return untreatable messages to their original queue. 

Each of the following represents a field in the specification. These are the optional arguments to B<new()> and are also read/write accessors:

=over 4

=item I<delivery_tag> (type: longlong)

=item I<requeue> (type: bit)

Requeue the message 

If this field is zero, the message will be discarded. If this bit is 1, the server will attempt to requeue the message. 

=back

=head2 Net::AMQP::Protocol::Basic::Recover

This class implements the class B<Basic> method B<Recover>, which is an asynchronous method.

This method asks the broker to redeliver all unacknowledged messages on a specifieid channel. Zero or more messages may be redelivered. 

Each of the following represents a field in the specification. These are the optional arguments to B<new()> and are also read/write accessors:

=over 4

=item I<requeue> (type: bit)

Requeue the message 

If this field is zero, the message will be redelivered to the original recipient. If this bit is 1, the server will attempt to requeue the message, potentially then delivering it to an alternative subscriber. 

=back

=head2 Net::AMQP::Protocol::Basic::ContentHeader

This class implements the class B<Basic> method B<ContentHeader>, which is an asynchronous method.

Each of the following represents a field in the specification. These are the optional arguments to B<new()> and are also read/write accessors:

=over 4

=item I<content_type> (type: shortstr)

=item I<content_encoding> (type: shortstr)

=item I<headers> (type: table)

=item I<delivery_mode> (type: octet)

=item I<priority> (type: octet)

=item I<correlation_id> (type: shortstr)

=item I<reply_to> (type: shortstr)

=item I<expiration> (type: shortstr)

=item I<message_id> (type: shortstr)

=item I<timestamp> (type: timestamp)

=item I<type> (type: shortstr)

=item I<user_id> (type: shortstr)

=item I<app_id> (type: shortstr)

=item I<cluster_id> (type: shortstr)

=back

=head2 Net::AMQP::Protocol::File::Qos

This class implements the class B<File> method B<Qos>, which is a synchronous method.

This method requests a specific quality of service. The QoS can be specified for the current channel or for all channels on the connection. The particular properties and semantics of a qos method always depend on the content class semantics. Though the qos method could in principle apply to both peers, it is currently meaningful only for the server. 

Each of the following represents a field in the specification. These are the optional arguments to B<new()> and are also read/write accessors:

=over 4

=item I<prefetch_size> (type: long)

Prefetch window in octets 

The client can request that messages be sent in advance so that when the client finishes processing a message, the following message is already held locally, rather than needing to be sent down the channel. Prefetching gives a performance improvement. This field specifies the prefetch window size in octets. May be set to zero, meaning "no specific limit". Note that other prefetch limits may still apply. The prefetch-size is ignored if the no-ack option is set. 

=item I<prefetch_count> (type: short)

Prefetch window in messages 

Specifies a prefetch window in terms of whole messages. This is compatible with some file API implementations. This field may be used in combination with the prefetch-size field; a message will only be sent in advance if both prefetch windows (and those at the channel and connection level) allow it. The prefetch-count is ignored if the no-ack option is set. 

=item I<global> (type: bit)

Apply to entire connection 

By default the QoS settings apply to the current channel only. If this field is set, they are applied to the entire connection. 

=back

=head2 Net::AMQP::Protocol::File::QosOk

This class implements the class B<File> method B<QosOk>, which is a synchronous method.

This method tells the client that the requested QoS levels could be handled by the server. The requested QoS applies to all active consumers until a new QoS is defined. 

This class has no fields nor accessors.

=head2 Net::AMQP::Protocol::File::Consume

This class implements the class B<File> method B<Consume>, which is a synchronous method.

This method asks the server to start a "consumer", which is a transient request for messages from a specific queue. Consumers last as long as the channel they were created on, or until the client cancels them. 

Each of the following represents a field in the specification. These are the optional arguments to B<new()> and are also read/write accessors:

=over 4

=item I<ticket> (type: short)

=item I<queue> (type: shortstr)

Specifies the name of the queue to consume from. If the queue name is null, refers to the current queue for the channel, which is the last declared queue. 

=item I<consumer_tag> (type: shortstr)

Specifies the identifier for the consumer. The consumer tag is local to a connection, so two clients can use the same consumer tags. If this field is empty the server will generate a unique tag. 

=item I<no_local> (type: bit)

=item I<no_ack> (type: bit)

=item I<exclusive> (type: bit)

Request exclusive access 

Request exclusive consumer access, meaning only this consumer can access the queue. 

=item I<nowait> (type: bit)

Do not send a reply method 

If set, the server will not respond to the method. The client should not wait for a reply method. If the server could not complete the method it will raise a channel or connection exception. 

=back

=head2 Net::AMQP::Protocol::File::ConsumeOk

This class implements the class B<File> method B<ConsumeOk>, which is a synchronous method.

This method provides the client with a consumer tag which it MUST use in methods that work with the consumer. 

Each of the following represents a field in the specification. These are the optional arguments to B<new()> and are also read/write accessors:

=over 4

=item I<consumer_tag> (type: shortstr)

Holds the consumer tag specified by the client or provided by the server. 

=back

=head2 Net::AMQP::Protocol::File::Cancel

This class implements the class B<File> method B<Cancel>, which is a synchronous method.

This method cancels a consumer. This does not affect already delivered messages, but it does mean the server will not send any more messages for that consumer. 

Each of the following represents a field in the specification. These are the optional arguments to B<new()> and are also read/write accessors:

=over 4

=item I<consumer_tag> (type: shortstr)

=item I<nowait> (type: bit)

Do not send a reply method 

If set, the server will not respond to the method. The client should not wait for a reply method. If the server could not complete the method it will raise a channel or connection exception. 

=back

=head2 Net::AMQP::Protocol::File::CancelOk

This class implements the class B<File> method B<CancelOk>, which is a synchronous method.

This method confirms that the cancellation was completed. 

Each of the following represents a field in the specification. These are the optional arguments to B<new()> and are also read/write accessors:

=over 4

=item I<consumer_tag> (type: shortstr)

=back

=head2 Net::AMQP::Protocol::File::Open

This class implements the class B<File> method B<Open>, which is a synchronous method.

This method requests permission to start staging a message. Staging means sending the message into a temporary area at the recipient end and then delivering the message by referring to this temporary area. Staging is how the protocol handles partial file transfers - if a message is partially staged and the connection breaks, the next time the sender starts to stage it, it can restart from where it left off. 

Each of the following represents a field in the specification. These are the optional arguments to B<new()> and are also read/write accessors:

=over 4

=item I<identifier> (type: shortstr)

Staging identifier 

This is the staging identifier. This is an arbitrary string chosen by the sender. For staging to work correctly the sender must use the same staging identifier when staging the same message a second time after recovery from a failure. A good choice for the staging identifier would be the SHA1 hash of the message properties data (including the original filename, revised time, etc.). 

=item I<content_size> (type: longlong)

Message content size 

The size of the content in octets. The recipient may use this information to allocate or check available space in advance, to avoid "disk full" errors during staging of very large messages. 

=back

=head2 Net::AMQP::Protocol::File::OpenOk

This class implements the class B<File> method B<OpenOk>, which is a synchronous method.

This method confirms that the recipient is ready to accept staged data. If the message was already partially-staged at a previous time the recipient will report the number of octets already staged. 

Each of the following represents a field in the specification. These are the optional arguments to B<new()> and are also read/write accessors:

=over 4

=item I<staged_size> (type: longlong)

Already staged amount 

The amount of previously-staged content in octets. For a new message this will be zero. 

=back

=head2 Net::AMQP::Protocol::File::Stage

This class implements the class B<File> method B<Stage>, which is an asynchronous method.

This method stages the message, sending the message content to the recipient from the octet offset specified in the Open-Ok method. 

This class has no fields nor accessors.

=head2 Net::AMQP::Protocol::File::Publish

This class implements the class B<File> method B<Publish>, which is an asynchronous method.

This method publishes a staged file message to a specific exchange. The file message will be routed to queues as defined by the exchange configuration and distributed to any active consumers when the transaction, if any, is committed. 

Each of the following represents a field in the specification. These are the optional arguments to B<new()> and are also read/write accessors:

=over 4

=item I<ticket> (type: short)

=item I<exchange> (type: shortstr)

Specifies the name of the exchange to publish to. The exchange name can be empty, meaning the default exchange. If the exchange name is specified, and that exchange does not exist, the server will raise a channel exception. 

=item I<routing_key> (type: shortstr)

Message routing key 

Specifies the routing key for the message. The routing key is used for routing messages depending on the exchange configuration. 

=item I<mandatory> (type: bit)

Indicate mandatory routing 

This flag tells the server how to react if the message cannot be routed to a queue. If this flag is set, the server will return an unroutable message with a Return method. If this flag is zero, the server silently drops the message. 

=item I<immediate> (type: bit)

Request immediate delivery 

This flag tells the server how to react if the message cannot be routed to a queue consumer immediately. If this flag is set, the server will return an undeliverable message with a Return method. If this flag is zero, the server will queue the message, but with no guarantee that it will ever be consumed. 

=item I<identifier> (type: shortstr)

Staging identifier 

This is the staging identifier of the message to publish. The message must have been staged. Note that a client can send the Publish method asynchronously without waiting for staging to finish. 

=back

=head2 Net::AMQP::Protocol::File::Return

This class implements the class B<File> method B<Return>, which is an asynchronous method.

This method returns an undeliverable message that was published with the "immediate" flag set, or an unroutable message published with the "mandatory" flag set. The reply code and text provide information about the reason that the message was undeliverable. 

Each of the following represents a field in the specification. These are the optional arguments to B<new()> and are also read/write accessors:

=over 4

=item I<reply_code> (type: short)

=item I<reply_text> (type: shortstr)

=item I<exchange> (type: shortstr)

Specifies the name of the exchange that the message was originally published to. 

=item I<routing_key> (type: shortstr)

Message routing key 

Specifies the routing key name specified when the message was published. 

=back

=head2 Net::AMQP::Protocol::File::Deliver

This class implements the class B<File> method B<Deliver>, which is an asynchronous method.

This method delivers a staged file message to the client, via a consumer. In the asynchronous message delivery model, the client starts a consumer using the Consume method, then the server responds with Deliver methods as and when messages arrive for that consumer. 

Each of the following represents a field in the specification. These are the optional arguments to B<new()> and are also read/write accessors:

=over 4

=item I<consumer_tag> (type: shortstr)

=item I<delivery_tag> (type: longlong)

=item I<redelivered> (type: bit)

=item I<exchange> (type: shortstr)

Specifies the name of the exchange that the message was originally published to. 

=item I<routing_key> (type: shortstr)

Message routing key 

Specifies the routing key name specified when the message was published. 

=item I<identifier> (type: shortstr)

Staging identifier 

This is the staging identifier of the message to deliver. The message must have been staged. Note that a server can send the Deliver method asynchronously without waiting for staging to finish. 

=back

=head2 Net::AMQP::Protocol::File::Ack

This class implements the class B<File> method B<Ack>, which is an asynchronous method.

This method acknowledges one or more messages delivered via the Deliver method. The client can ask to confirm a single message or a set of messages up to and including a specific message. 

Each of the following represents a field in the specification. These are the optional arguments to B<new()> and are also read/write accessors:

=over 4

=item I<delivery_tag> (type: longlong)

=item I<multiple> (type: bit)

Acknowledge multiple messages 

If set to 1, the delivery tag is treated as "up to and including", so that the client can acknowledge multiple messages with a single method. If set to zero, the delivery tag refers to a single message. If the multiple field is 1, and the delivery tag is zero, tells the server to acknowledge all outstanding mesages. 

=back

=head2 Net::AMQP::Protocol::File::Reject

This class implements the class B<File> method B<Reject>, which is an asynchronous method.

This method allows a client to reject a message. It can be used to return untreatable messages to their original queue. Note that file content is staged before delivery, so the client will not use this method to interrupt delivery of a large message. 

Each of the following represents a field in the specification. These are the optional arguments to B<new()> and are also read/write accessors:

=over 4

=item I<delivery_tag> (type: longlong)

=item I<requeue> (type: bit)

Requeue the message 

If this field is zero, the message will be discarded. If this bit is 1, the server will attempt to requeue the message. 

=back

=head2 Net::AMQP::Protocol::File::ContentHeader

This class implements the class B<File> method B<ContentHeader>, which is an asynchronous method.

Each of the following represents a field in the specification. These are the optional arguments to B<new()> and are also read/write accessors:

=over 4

=item I<content_type> (type: shortstr)

=item I<content_encoding> (type: shortstr)

=item I<headers> (type: table)

=item I<priority> (type: octet)

=item I<reply_to> (type: shortstr)

=item I<message_id> (type: shortstr)

=item I<filename> (type: shortstr)

=item I<timestamp> (type: timestamp)

=item I<cluster_id> (type: shortstr)

=back

=head2 Net::AMQP::Protocol::Stream::Qos

This class implements the class B<Stream> method B<Qos>, which is a synchronous method.

This method requests a specific quality of service. The QoS can be specified for the current channel or for all channels on the connection. The particular properties and semantics of a qos method always depend on the content class semantics. Though the qos method could in principle apply to both peers, it is currently meaningful only for the server. 

Each of the following represents a field in the specification. These are the optional arguments to B<new()> and are also read/write accessors:

=over 4

=item I<prefetch_size> (type: long)

Prefetch window in octets 

The client can request that messages be sent in advance so that when the client finishes processing a message, the following message is already held locally, rather than needing to be sent down the channel. Prefetching gives a performance improvement. This field specifies the prefetch window size in octets. May be set to zero, meaning "no specific limit". Note that other prefetch limits may still apply. 

=item I<prefetch_count> (type: short)

Prefetch window in messages 

Specifies a prefetch window in terms of whole messages. This field may be used in combination with the prefetch-size field; a message will only be sent in advance if both prefetch windows (and those at the channel and connection level) allow it. 

=item I<consume_rate> (type: long)

Transfer rate in octets/second 

Specifies a desired transfer rate in octets per second. This is usually determined by the application that uses the streaming data. A value of zero means "no limit", i.e. as rapidly as possible. 

=item I<global> (type: bit)

Apply to entire connection 

By default the QoS settings apply to the current channel only. If this field is set, they are applied to the entire connection. 

=back

=head2 Net::AMQP::Protocol::Stream::QosOk

This class implements the class B<Stream> method B<QosOk>, which is a synchronous method.

This method tells the client that the requested QoS levels could be handled by the server. The requested QoS applies to all active consumers until a new QoS is defined. 

This class has no fields nor accessors.

=head2 Net::AMQP::Protocol::Stream::Consume

This class implements the class B<Stream> method B<Consume>, which is a synchronous method.

This method asks the server to start a "consumer", which is a transient request for messages from a specific queue. Consumers last as long as the channel they were created on, or until the client cancels them. 

Each of the following represents a field in the specification. These are the optional arguments to B<new()> and are also read/write accessors:

=over 4

=item I<ticket> (type: short)

=item I<queue> (type: shortstr)

Specifies the name of the queue to consume from. If the queue name is null, refers to the current queue for the channel, which is the last declared queue. 

=item I<consumer_tag> (type: shortstr)

Specifies the identifier for the consumer. The consumer tag is local to a connection, so two clients can use the same consumer tags. If this field is empty the server will generate a unique tag. 

=item I<no_local> (type: bit)

=item I<exclusive> (type: bit)

Request exclusive access 

Request exclusive consumer access, meaning only this consumer can access the queue. 

=item I<nowait> (type: bit)

Do not send a reply method 

If set, the server will not respond to the method. The client should not wait for a reply method. If the server could not complete the method it will raise a channel or connection exception. 

=back

=head2 Net::AMQP::Protocol::Stream::ConsumeOk

This class implements the class B<Stream> method B<ConsumeOk>, which is a synchronous method.

This method provides the client with a consumer tag which it may use in methods that work with the consumer. 

Each of the following represents a field in the specification. These are the optional arguments to B<new()> and are also read/write accessors:

=over 4

=item I<consumer_tag> (type: shortstr)

Holds the consumer tag specified by the client or provided by the server. 

=back

=head2 Net::AMQP::Protocol::Stream::Cancel

This class implements the class B<Stream> method B<Cancel>, which is a synchronous method.

This method cancels a consumer. Since message delivery is asynchronous the client may continue to receive messages for a short while after canceling a consumer. It may process or discard these as appropriate. 

Each of the following represents a field in the specification. These are the optional arguments to B<new()> and are also read/write accessors:

=over 4

=item I<consumer_tag> (type: shortstr)

=item I<nowait> (type: bit)

Do not send a reply method 

If set, the server will not respond to the method. The client should not wait for a reply method. If the server could not complete the method it will raise a channel or connection exception. 

=back

=head2 Net::AMQP::Protocol::Stream::CancelOk

This class implements the class B<Stream> method B<CancelOk>, which is a synchronous method.

This method confirms that the cancellation was completed. 

Each of the following represents a field in the specification. These are the optional arguments to B<new()> and are also read/write accessors:

=over 4

=item I<consumer_tag> (type: shortstr)

=back

=head2 Net::AMQP::Protocol::Stream::Publish

This class implements the class B<Stream> method B<Publish>, which is an asynchronous method.

This method publishes a message to a specific exchange. The message will be routed to queues as defined by the exchange configuration and distributed to any active consumers as appropriate. 

Each of the following represents a field in the specification. These are the optional arguments to B<new()> and are also read/write accessors:

=over 4

=item I<ticket> (type: short)

=item I<exchange> (type: shortstr)

Specifies the name of the exchange to publish to. The exchange name can be empty, meaning the default exchange. If the exchange name is specified, and that exchange does not exist, the server will raise a channel exception. 

=item I<routing_key> (type: shortstr)

Message routing key 

Specifies the routing key for the message. The routing key is used for routing messages depending on the exchange configuration. 

=item I<mandatory> (type: bit)

Indicate mandatory routing 

This flag tells the server how to react if the message cannot be routed to a queue. If this flag is set, the server will return an unroutable message with a Return method. If this flag is zero, the server silently drops the message. 

=item I<immediate> (type: bit)

Request immediate delivery 

This flag tells the server how to react if the message cannot be routed to a queue consumer immediately. If this flag is set, the server will return an undeliverable message with a Return method. If this flag is zero, the server will queue the message, but with no guarantee that it will ever be consumed. 

=back

=head2 Net::AMQP::Protocol::Stream::Return

This class implements the class B<Stream> method B<Return>, which is an asynchronous method.

This method returns an undeliverable message that was published with the "immediate" flag set, or an unroutable message published with the "mandatory" flag set. The reply code and text provide information about the reason that the message was undeliverable. 

Each of the following represents a field in the specification. These are the optional arguments to B<new()> and are also read/write accessors:

=over 4

=item I<reply_code> (type: short)

=item I<reply_text> (type: shortstr)

=item I<exchange> (type: shortstr)

Specifies the name of the exchange that the message was originally published to. 

=item I<routing_key> (type: shortstr)

Message routing key 

Specifies the routing key name specified when the message was published. 

=back

=head2 Net::AMQP::Protocol::Stream::Deliver

This class implements the class B<Stream> method B<Deliver>, which is an asynchronous method.

This method delivers a message to the client, via a consumer. In the asynchronous message delivery model, the client starts a consumer using the Consume method, then the server responds with Deliver methods as and when messages arrive for that consumer. 

Each of the following represents a field in the specification. These are the optional arguments to B<new()> and are also read/write accessors:

=over 4

=item I<consumer_tag> (type: shortstr)

=item I<delivery_tag> (type: longlong)

=item I<exchange> (type: shortstr)

Specifies the name of the exchange that the message was originally published to. 

=item I<queue> (type: shortstr)

Specifies the name of the queue that the message came from. Note that a single channel can start many consumers on different queues. 

=back

=head2 Net::AMQP::Protocol::Stream::ContentHeader

This class implements the class B<Stream> method B<ContentHeader>, which is an asynchronous method.

Each of the following represents a field in the specification. These are the optional arguments to B<new()> and are also read/write accessors:

=over 4

=item I<content_type> (type: shortstr)

=item I<content_encoding> (type: shortstr)

=item I<headers> (type: table)

=item I<priority> (type: octet)

=item I<timestamp> (type: timestamp)

=back

=head2 Net::AMQP::Protocol::Tx::Select

This class implements the class B<Tx> method B<Select>, which is a synchronous method.

This method sets the channel to use standard transactions. The client must use this method at least once on a channel before using the Commit or Rollback methods. 

This class has no fields nor accessors.

=head2 Net::AMQP::Protocol::Tx::SelectOk

This class implements the class B<Tx> method B<SelectOk>, which is a synchronous method.

This method confirms to the client that the channel was successfully set to use standard transactions. 

This class has no fields nor accessors.

=head2 Net::AMQP::Protocol::Tx::Commit

This class implements the class B<Tx> method B<Commit>, which is a synchronous method.

This method commits all messages published and acknowledged in the current transaction. A new transaction starts immediately after a commit. 

This class has no fields nor accessors.

=head2 Net::AMQP::Protocol::Tx::CommitOk

This class implements the class B<Tx> method B<CommitOk>, which is a synchronous method.

This method confirms to the client that the commit succeeded. Note that if a commit fails, the server raises a channel exception. 

This class has no fields nor accessors.

=head2 Net::AMQP::Protocol::Tx::Rollback

This class implements the class B<Tx> method B<Rollback>, which is a synchronous method.

This method abandons all messages published and acknowledged in the current transaction. A new transaction starts immediately after a rollback. 

This class has no fields nor accessors.

=head2 Net::AMQP::Protocol::Tx::RollbackOk

This class implements the class B<Tx> method B<RollbackOk>, which is a synchronous method.

This method confirms to the client that the rollback succeeded. Note that if an rollback fails, the server raises a channel exception. 

This class has no fields nor accessors.

=head2 Net::AMQP::Protocol::Dtx::Select

This class implements the class B<Dtx> method B<Select>, which is a synchronous method.

This method sets the channel to use distributed transactions. The client must use this method at least once on a channel before using the Start method. 

This class has no fields nor accessors.

=head2 Net::AMQP::Protocol::Dtx::SelectOk

This class implements the class B<Dtx> method B<SelectOk>, which is a synchronous method.

This method confirms to the client that the channel was successfully set to use distributed transactions. 

This class has no fields nor accessors.

=head2 Net::AMQP::Protocol::Dtx::Start

This class implements the class B<Dtx> method B<Start>, which is a synchronous method.

This method starts a new distributed transaction. This must be the first method on a new channel that uses the distributed transaction mode, before any methods that publish or consume messages. 

Each of the following represents a field in the specification. These are the optional arguments to B<new()> and are also read/write accessors:

=over 4

=item I<dtx_identifier> (type: shortstr)

Transaction identifier 

The distributed transaction key. This identifies the transaction so that the AMQP server can coordinate with the distributed transaction coordinator. 

=back

=head2 Net::AMQP::Protocol::Dtx::StartOk

This class implements the class B<Dtx> method B<StartOk>, which is a synchronous method.

This method confirms to the client that the transaction started. Note that if a start fails, the server raises a channel exception. 

This class has no fields nor accessors.

=head2 Net::AMQP::Protocol::Tunnel::Request

This class implements the class B<Tunnel> method B<Request>, which is an asynchronous method.

This method tunnels a block of binary data, which can be an encoded AMQP method or other data. The binary data is sent as the content for the Tunnel.Request method. 

Each of the following represents a field in the specification. These are the optional arguments to B<new()> and are also read/write accessors:

=over 4

=item I<meta_data> (type: table)

Meta data for the tunnelled block 

This field table holds arbitrary meta-data that the sender needs to pass to the recipient. 

=back

=head2 Net::AMQP::Protocol::Tunnel::ContentHeader

This class implements the class B<Tunnel> method B<ContentHeader>, which is an asynchronous method.

Each of the following represents a field in the specification. These are the optional arguments to B<new()> and are also read/write accessors:

=over 4

=item I<headers> (type: table)

=item I<proxy_name> (type: shortstr)

=item I<data_name> (type: shortstr)

=item I<durable> (type: octet)

=item I<broadcast> (type: octet)

=back

=head2 Net::AMQP::Protocol::Test::Integer

This class implements the class B<Test> method B<Integer>, which is a synchronous method.

This method tests the peer's capability to correctly marshal integer data. 

Each of the following represents a field in the specification. These are the optional arguments to B<new()> and are also read/write accessors:

=over 4

=item I<integer_1> (type: octet)

Octet test value 

An octet integer test value. 

=item I<integer_2> (type: short)

Short test value 

A short integer test value. 

=item I<integer_3> (type: long)

Long test value 

A long integer test value. 

=item I<integer_4> (type: longlong)

Long-long test value 

A long long integer test value. 

=item I<operation> (type: octet)

Operation to test 

The client must execute this operation on the provided integer test fields and return the result. 

=back

=head2 Net::AMQP::Protocol::Test::IntegerOk

This class implements the class B<Test> method B<IntegerOk>, which is a synchronous method.

This method reports the result of an Integer method. 

Each of the following represents a field in the specification. These are the optional arguments to B<new()> and are also read/write accessors:

=over 4

=item I<result> (type: longlong)

Result value 

The result of the tested operation. 

=back

=head2 Net::AMQP::Protocol::Test::String

This class implements the class B<Test> method B<String>, which is a synchronous method.

This method tests the peer's capability to correctly marshal string data. 

Each of the following represents a field in the specification. These are the optional arguments to B<new()> and are also read/write accessors:

=over 4

=item I<string_1> (type: shortstr)

Short string test value 

An short string test value. 

=item I<string_2> (type: longstr)

Long string test value 

A long string test value. 

=item I<operation> (type: octet)

Operation to test 

The client must execute this operation on the provided string test fields and return the result. 

=back

=head2 Net::AMQP::Protocol::Test::StringOk

This class implements the class B<Test> method B<StringOk>, which is a synchronous method.

This method reports the result of a String method. 

Each of the following represents a field in the specification. These are the optional arguments to B<new()> and are also read/write accessors:

=over 4

=item I<result> (type: longstr)

Result value 

The result of the tested operation. 

=back

=head2 Net::AMQP::Protocol::Test::Table

This class implements the class B<Test> method B<Table>, which is a synchronous method.

This method tests the peer's capability to correctly marshal field table data. 

Each of the following represents a field in the specification. These are the optional arguments to B<new()> and are also read/write accessors:

=over 4

=item I<table> (type: table)

Field table of test values 

A field table of test values. 

=item I<integer_op> (type: octet)

Operation to test on integers 

The client must execute this operation on the provided field table integer values and return the result. 

=item I<string_op> (type: octet)

Operation to test on strings 

The client must execute this operation on the provided field table string values and return the result. 

=back

=head2 Net::AMQP::Protocol::Test::TableOk

This class implements the class B<Test> method B<TableOk>, which is a synchronous method.

This method reports the result of a Table method. 

Each of the following represents a field in the specification. These are the optional arguments to B<new()> and are also read/write accessors:

=over 4

=item I<integer_result> (type: longlong)

Integer result value 

The result of the tested integer operation. 

=item I<string_result> (type: longstr)

String result value 

The result of the tested string operation. 

=back

=head2 Net::AMQP::Protocol::Test::Content

This class implements the class B<Test> method B<Content>, which is a synchronous method.

This method tests the peer's capability to correctly marshal content. 

This class has no fields nor accessors.

=head2 Net::AMQP::Protocol::Test::ContentOk

This class implements the class B<Test> method B<ContentOk>, which is a synchronous method.

This method reports the result of a Content method. It contains the content checksum and echoes the original content as provided. 

Each of the following represents a field in the specification. These are the optional arguments to B<new()> and are also read/write accessors:

=over 4

=item I<content_checksum> (type: long)

Content hash 

The 32-bit checksum of the content, calculated by adding the content into a 32-bit accumulator. 

=back

=cut


__DATA__
<?xml version="1.0"?>

<!--
Copyright Notice
================
© Copyright JPMorgan Chase Bank, Cisco Systems, Inc., Envoy Technologies Inc.,
iMatix Corporation, IONA� Technologies, Red Hat, Inc.,
TWIST Process Innovations, and 29West Inc. 2006. All rights reserved.

License
=======
JPMorgan Chase Bank, Cisco Systems, Inc., Envoy Technologies Inc., iMatix 
Corporation, IONA� Technologies, Red Hat, Inc., TWIST Process Innovations, and 
29West Inc. (collectively, the "Authors") each hereby grants to you a worldwide,
perpetual, royalty-free, nontransferable, nonexclusive license to
(i) copy, display, and implement the Advanced Messaging Queue Protocol
("AMQP") Specification and (ii) the Licensed Claims that are held by
the Authors, all for the purpose of implementing the Advanced Messaging
Queue Protocol Specification. Your license and any rights under this
Agreement will terminate immediately without notice from
any Author if you bring any claim, suit, demand, or action related to
the Advanced Messaging Queue Protocol Specification against any Author.
Upon termination, you shall destroy all copies of the Advanced Messaging
Queue Protocol Specification in your possession or control.

As used hereunder, "Licensed Claims" means those claims of a patent or
patent application, throughout the world, excluding design patents and
design registrations, owned or controlled, or that can be sublicensed
without fee and in compliance with the requirements of this
Agreement, by an Author or its affiliates now or at any
future time and which would necessarily be infringed by implementation
of the Advanced Messaging Queue Protocol Specification. A claim is
necessarily infringed hereunder only when it is not possible to avoid
infringing it because there is no plausible non-infringing alternative
for implementing the required portions of the Advanced Messaging Queue
Protocol Specification. Notwithstanding the foregoing, Licensed Claims
shall not include any claims other than as set forth above even if
contained in the same patent as Licensed Claims; or that read solely
on any implementations of any portion of the Advanced Messaging Queue
Protocol Specification that are not required by the Advanced Messaging
Queue Protocol Specification, or that, if licensed, would require a
payment of royalties by the licensor to unaffiliated third parties.
Moreover, Licensed Claims shall not include (i) any enabling technologies
that may be necessary to make or use any Licensed Product but are not
themselves expressly set forth in the Advanced Messaging Queue Protocol
Specification (e.g., semiconductor manufacturing technology, compiler
technology, object oriented technology, networking technology, operating
system technology, and the like); or (ii) the implementation of other
published standards developed elsewhere and merely referred to in the
body of the Advanced Messaging Queue Protocol Specification, or
(iii) any Licensed Product and any combinations thereof the purpose or
function of which is not required for compliance with the Advanced
Messaging Queue Protocol Specification. For purposes of this definition,
the Advanced Messaging Queue Protocol Specification shall be deemed to
include both architectural and interconnection requirements essential
for interoperability and may also include supporting source code artifacts
where such architectural, interconnection requirements and source code
artifacts are expressly identified as being required or documentation to
achieve compliance with the Advanced Messaging Queue Protocol Specification.

As used hereunder, "Licensed Products" means only those specific portions
of products (hardware, software or combinations thereof) that implement
and are compliant with all relevant portions of the Advanced Messaging
Queue Protocol Specification.

The following disclaimers, which you hereby also acknowledge as to any
use you may make of the Advanced Messaging Queue Protocol Specification:

THE ADVANCED MESSAGING QUEUE PROTOCOL SPECIFICATION IS PROVIDED "AS IS,"
AND THE AUTHORS MAKE NO REPRESENTATIONS OR WARRANTIES, EXPRESS OR
IMPLIED, INCLUDING, BUT NOT LIMITED TO, WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE, NON-INFRINGEMENT, OR TITLE; THAT THE
CONTENTS OF THE ADVANCED MESSAGING QUEUE PROTOCOL SPECIFICATION ARE
SUITABLE FOR ANY PURPOSE; NOR THAT THE IMPLEMENTATION OF THE ADVANCED
MESSAGING QUEUE PROTOCOL SPECIFICATION WILL NOT INFRINGE ANY THIRD PARTY 
PATENTS, COPYRIGHTS, TRADEMARKS OR OTHER RIGHTS.

THE AUTHORS WILL NOT BE LIABLE FOR ANY DIRECT, INDIRECT, SPECIAL,
INCIDENTAL OR CONSEQUENTIAL DAMAGES ARISING OUT OF OR RELATING TO ANY
USE, IMPLEMENTATION OR DISTRIBUTION OF THE ADVANCED MESSAGING QUEUE
PROTOCOL SPECIFICATION.

The name and trademarks of the Authors may NOT be used in any manner,
including advertising or publicity pertaining to the Advanced Messaging
Queue Protocol Specification or its contents without specific, written
prior permission. Title to copyright in the Advanced Messaging Queue
Protocol Specification will at all times remain with the Authors.

No other rights are granted by implication, estoppel or otherwise.

Upon termination of your license or rights under this Agreement, you
shall destroy all copies of the Advanced Messaging Queue Protocol
Specification in your possession or control.

Trademarks
==========
"JPMorgan", "JPMorgan Chase", "Chase", the JPMorgan Chase logo and the
Octagon Symbol are trademarks of JPMorgan Chase & Co.

IMATIX and the iMatix logo are trademarks of iMatix Corporation sprl.

IONA, IONA Technologies, and the IONA logos are trademarks of IONA
Technologies PLC and/or its subsidiaries.

LINUX is a trademark of Linus Torvalds. RED HAT and JBOSS are registered
trademarks of Red Hat, Inc. in the US and other countries.

Java, all Java-based trademarks and OpenOffice.org are trademarks of
Sun Microsystems, Inc. in the United States, other countries, or both.

Other company, product, or service names may be trademarks or service
marks of others.

Links to full AMQP specification:
=================================
http://www.envoytech.org/spec/amq/
http://www.iona.com/opensource/amqp/
http://www.redhat.com/solutions/specifications/amqp/
http://www.twiststandards.org/tiki-index.php?page=AMQ
http://www.imatix.com/amqp

-->

<amqp major="8" minor="0" port="5672" comment="AMQ protocol 0.80">
    AMQ Protocol 0.80
<!--
======================================================
==       CONSTANTS
======================================================
-->
  <constant name="frame method" value="1"/>
  <constant name="frame header" value="2"/>
  <constant name="frame body" value="3"/>
  <constant name="frame oob method" value="4"/>
  <constant name="frame oob header" value="5"/>
  <constant name="frame oob body" value="6"/>
  <constant name="frame trace" value="7"/>
  <constant name="frame heartbeat" value="8"/>
  <constant name="frame min size" value="4096"/>
  <constant name="frame end" value="206"/>
  <constant name="reply success" value="200">
  Indicates that the method completed successfully. This reply code is
  reserved for future use - the current protocol design does not use
  positive confirmation and reply codes are sent only in case of an
  error.
</constant>
  <constant name="not delivered" value="310" class="soft error">
  The client asked for a specific message that is no longer available.
  The message was delivered to another client, or was purged from the
  queue for some other reason.
</constant>
  <constant name="content too large" value="311" class="soft error">
  The client attempted to transfer content larger than the server
  could accept at the present time.  The client may retry at a later
  time.
</constant>
  <constant name="connection forced" value="320" class="hard error">
  An operator intervened to close the connection for some reason.
  The client may retry at some later date.
</constant>
  <constant name="invalid path" value="402" class="hard error">
  The client tried to work with an unknown virtual host or cluster.
</constant>
  <constant name="access refused" value="403" class="soft error">
  The client attempted to work with a server entity to which it has
  no  due to security settings.
</constant>
  <constant name="not found" value="404" class="soft error">
  The client attempted to work with a server entity that does not exist.
</constant>
  <constant name="resource locked" value="405" class="soft error">
  The client attempted to work with a server entity to which it has
  no access because another client is working with it.
</constant>
  <constant name="frame error" value="501" class="hard error">
  The client sent a malformed frame that the server could not decode.
  This strongly implies a programming error in the client.
</constant>
  <constant name="syntax error" value="502" class="hard error">
  The client sent a frame that contained illegal values for one or more
  fields.  This strongly implies a programming error in the client.
</constant>
  <constant name="command invalid" value="503" class="hard error">
  The client sent an invalid sequence of frames, attempting to perform
  an operation that was considered invalid by the server. This usually
  implies a programming error in the client.
</constant>
  <constant name="channel error" value="504" class="hard error">
  The client attempted to work with a channel that had not been
  correctly opened.  This most likely indicates a fault in the client
  layer.
</constant>
  <constant name="resource error" value="506" class="hard error">
  The server could not complete the method because it lacked sufficient
  resources. This may be due to the client creating too many of some
  type of entity.
</constant>
  <constant name="not allowed" value="530" class="hard error">
  The client tried to work with some entity in a manner that is
  prohibited by the server, due to security settings or by some other
  criteria.
</constant>
  <constant name="not implemented" value="540" class="hard error">
  The client tried to use functionality that is not implemented in the
  server.
</constant>
  <constant name="internal error" value="541" class="hard error">
  The server could not complete the method because of an internal error.
  The server may require intervention by an operator in order to resume
  normal operations.
</constant>
  <!--
======================================================
==       DOMAIN TYPES
======================================================
-->
  <domain name="access ticket" type="short">
    access ticket granted by server
    <doc>
    An access ticket granted by the server for a certain set of access
    rights within a specific realm. Access tickets are valid within the
    channel where they were created, and expire when the channel closes.
    </doc>
    <assert check="ne" value="0"/>
  </domain>
  <domain name="class id" type="short"/>
  <domain name="consumer tag" type="shortstr">
    consumer tag
    <doc>
      Identifier for the consumer, valid within the current connection.
    </doc>
    <rule implement="MUST">
      The consumer tag is valid only within the channel from which the
      consumer was created. I.e. a client MUST NOT create a consumer in
      one channel and then use it in another.
    </rule>
  </domain>
  <domain name="delivery tag" type="longlong">
    server-assigned delivery tag
    <doc>
      The server-assigned and channel-specific delivery tag
    </doc>
    <rule implement="MUST">
      The delivery tag is valid only within the channel from which the
      message was received.  I.e. a client MUST NOT receive a message on
      one channel and then acknowledge it on another.
    </rule>
    <rule implement="MUST">
      The server MUST NOT use a zero value for delivery tags.  Zero is
      reserved for client use, meaning "all messages so far received".
    </rule>
  </domain>
  <domain name="exchange name" type="shortstr">
    exchange name
    <doc>
      The exchange name is a client-selected string that identifies
      the exchange for publish methods.  Exchange names may consist
      of any mixture of digits, letters, and underscores.  Exchange
      names are scoped by the virtual host.
    </doc>
    <assert check="length" value="127"/>
  </domain>
  <domain name="known hosts" type="shortstr">
list of known hosts
<doc>
Specifies the list of equivalent or alternative hosts that the server
knows about, which will normally include the current server itself.
Clients can cache this information and use it when reconnecting to a
server after a failure.
</doc>
    <rule implement="MAY">
The server MAY leave this field empty if it knows of no other
hosts than itself.
</rule>
  </domain>
  <domain name="method id" type="short"/>
  <domain name="no ack" type="bit">
    no acknowledgement needed
    <doc>
      If this field is set the server does not expect acknowledgments
      for messages.  That is, when a message is delivered to the client
      the server automatically and silently acknowledges it on behalf
      of the client.  This functionality increases performance but at
      the cost of reliability.  Messages can get lost if a client dies
      before it can deliver them to the application.
    </doc>
  </domain>
  <domain name="no local" type="bit">
    do not deliver own messages
    <doc>
    If the no-local field is set the server will not send messages to
    the client that published them.
    </doc>
  </domain>
  <domain name="path" type="shortstr">
    <doc>
  Must start with a slash "/" and continue with path names
  separated by slashes. A path name consists of any combination
  of at least one of [A-Za-z0-9] plus zero or more of [.-_+!=:].
</doc>
    <assert check="notnull"/>
    <assert check="syntax" rule="path"/>
    <assert check="length" value="127"/>
  </domain>
  <domain name="peer properties" type="table">
    <doc>
This string provides a set of peer properties, used for
identification, debugging, and general information.
</doc>
    <rule implement="SHOULD">
The properties SHOULD contain these fields:
"product", giving the name of the peer product, "version", giving
the name of the peer version, "platform", giving the name of the
operating system, "copyright", if appropriate, and "information",
giving other general information.
</rule>
  </domain>
  <domain name="queue name" type="shortstr">
    queue name
    <doc>
    The queue name identifies the queue within the vhost.  Queue
    names may consist of any mixture of digits, letters, and
    underscores.
    </doc>
    <assert check="length" value="127"/>
  </domain>
  <domain name="redelivered" type="bit">
    message is being redelivered
    <doc>
      This indicates that the message has been previously delivered to
      this or another client.
    </doc>
    <rule implement="SHOULD">
      The server SHOULD try to signal redelivered messages when it can.
      When redelivering a message that was not successfully acknowledged,
      the server SHOULD deliver it to the original client if possible.
    </rule>
    <rule implement="MUST">
      The client MUST NOT rely on the redelivered field but MUST take it
      as a hint that the message may already have been processed.  A
      fully robust client must be able to track duplicate received messages
      on non-transacted, and locally-transacted channels.
    </rule>
  </domain>
  <domain name="reply code" type="short">
reply code from server
<doc>
  The reply code. The AMQ reply codes are defined in AMQ RFC 011.
</doc>
    <assert check="notnull"/>
  </domain>
  <domain name="reply text" type="shortstr">
localised reply text
<doc>
  The localised reply text.  This text can be logged as an aid to
  resolving issues.
</doc>
    <assert check="notnull"/>
  </domain>
  <class name="connection" handler="connection" index="10">
    <!--
======================================================
==       CONNECTION
======================================================
-->
  work with socket connections
<doc>
  The connection class provides methods for a client to establish a
  network connection to a server, and for both peers to operate the
  connection thereafter.
</doc>
    <doc name="grammar">
    connection          = open-connection *use-connection close-connection
    open-connection     = C:protocol-header
                          S:START C:START-OK
                          *challenge
                          S:TUNE C:TUNE-OK
                          C:OPEN S:OPEN-OK | S:REDIRECT
    challenge           = S:SECURE C:SECURE-OK
    use-connection      = *channel
    close-connection    = C:CLOSE S:CLOSE-OK
                        / S:CLOSE C:CLOSE-OK
</doc>
    <chassis name="server" implement="MUST"/>
    <chassis name="client" implement="MUST"/>
    <!-- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -->
    <method name="start" synchronous="1" index="10">
  start connection negotiation
  <doc>
    This method starts the connection negotiation process by telling
    the client the protocol version that the server proposes, along
    with a list of security mechanisms which the client can use for
    authentication.
  </doc>
      <rule implement="MUST">
    If the client cannot handle the protocol version suggested by the
    server it MUST close the socket connection.
  </rule>
      <rule implement="MUST">
    The server MUST provide a protocol version that is lower than or
    equal to that requested by the client in the protocol header. If
    the server cannot support the specified protocol it MUST NOT send
    this method, but MUST close the socket connection.
  </rule>
      <chassis name="client" implement="MUST"/>
      <response name="start-ok"/>
      <field name="version major" type="octet">
    protocol major version
    <doc>
      The protocol major version that the server agrees to use, which
      cannot be higher than the client's major version.
    </doc>
      </field>
      <field name="version minor" type="octet">
    protocol major version
    <doc>
      The protocol minor version that the server agrees to use, which
      cannot be higher than the client's minor version.
    </doc>
      </field>
      <field name="server properties" domain="peer properties">
    server properties
  </field>
      <field name="mechanisms" type="longstr">
    available security mechanisms
    <doc>
      A list of the security mechanisms that the server supports, delimited
      by spaces.  Currently ASL supports these mechanisms: PLAIN.
    </doc>
        <see name="security mechanisms"/>
        <assert check="notnull"/>
      </field>
      <field name="locales" type="longstr">
    available message locales
    <doc>
      A list of the message locales that the server supports, delimited
      by spaces.  The locale defines the language in which the server
      will send reply texts.
    </doc>
        <rule implement="MUST">
      All servers MUST support at least the en_US locale.
    </rule>
        <assert check="notnull"/>
      </field>
    </method>
    <method name="start-ok" synchronous="1" index="11">
  select security mechanism and locale
  <doc>
    This method selects a SASL security mechanism. ASL uses SASL
    (RFC2222) to negotiate authentication and encryption.
  </doc>
      <chassis name="server" implement="MUST"/>
      <field name="client properties" domain="peer properties">
    client properties
  </field>
      <field name="mechanism" type="shortstr">
    selected security mechanism
    <doc>
      A single security mechanisms selected by the client, which must be
      one of those specified by the server.
    </doc>
        <rule implement="SHOULD">
      The client SHOULD authenticate using the highest-level security
      profile it can handle from the list provided by the server.
    </rule>
        <rule implement="MUST">
    The mechanism field MUST contain one of the security mechanisms
    proposed by the server in the Start method. If it doesn't, the
    server MUST close the socket.
    </rule>
        <assert check="notnull"/>
      </field>
      <field name="response" type="longstr">
    security response data
    <doc>
      A block of opaque data passed to the security mechanism. The contents
      of this data are defined by the SASL security mechanism.  For the
      PLAIN security mechanism this is defined as a field table holding
      two fields, LOGIN and PASSWORD.
    </doc>
        <assert check="notnull"/>
      </field>
      <field name="locale" type="shortstr">
    selected message locale
    <doc>
      A single message local selected by the client, which must be one
      of those specified by the server.
    </doc>
        <assert check="notnull"/>
      </field>
    </method>
    <!-- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -->
    <method name="secure" synchronous="1" index="20">
  security mechanism challenge
  <doc>
    The SASL protocol works by exchanging challenges and responses until
    both peers have received sufficient information to authenticate each
    other.  This method challenges the client to provide more information.
  </doc>
      <chassis name="client" implement="MUST"/>
      <response name="secure-ok"/>
      <field name="challenge" type="longstr">
    security challenge data
    <doc>
      Challenge information, a block of opaque binary data passed to
      the security mechanism.
    </doc>
        <see name="security mechanisms"/>
      </field>
    </method>
    <method name="secure-ok" synchronous="1" index="21">
  security mechanism response
  <doc>
    This method attempts to authenticate, passing a block of SASL data
    for the security mechanism at the server side.
  </doc>
      <chassis name="server" implement="MUST"/>
      <field name="response" type="longstr">
    security response data
    <doc>
      A block of opaque data passed to the security mechanism.  The contents
      of this data are defined by the SASL security mechanism.
    </doc>
        <assert check="notnull"/>
      </field>
    </method>
    <!-- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -->
    <method name="tune" synchronous="1" index="30">
  propose connection tuning parameters
  <doc>
    This method proposes a set of connection configuration values
    to the client.  The client can accept and/or adjust these.
  </doc>
      <chassis name="client" implement="MUST"/>
      <response name="tune-ok"/>
      <field name="channel max" type="short">
    proposed maximum channels
    <doc>
      The maximum total number of channels that the server allows
      per connection. Zero means that the server does not impose a
      fixed limit, but the number of allowed channels may be limited
      by available server resources.
    </doc>
      </field>
      <field name="frame max" type="long">
    proposed maximum frame size
    <doc>
      The largest frame size that the server proposes for the
      connection. The client can negotiate a lower value.  Zero means
      that the server does not impose any specific limit but may reject
      very large frames if it cannot allocate resources for them.
    </doc>
        <rule implement="MUST">
      Until the frame-max has been negotiated, both peers MUST accept
      frames of up to 4096 octets large. The minimum non-zero value for
      the frame-max field is 4096.
    </rule>
      </field>
      <field name="heartbeat" type="short">
    desired heartbeat delay
    <doc>
      The delay, in seconds, of the connection heartbeat that the server
      wants.  Zero means the server does not want a heartbeat.
    </doc>
      </field>
    </method>
    <method name="tune-ok" synchronous="1" index="31">
  negotiate connection tuning parameters
  <doc>
    This method sends the client's connection tuning parameters to the
    server. Certain fields are negotiated, others provide capability
    information.
  </doc>
      <chassis name="server" implement="MUST"/>
      <field name="channel max" type="short">
    negotiated maximum channels
    <doc>
      The maximum total number of channels that the client will use
      per connection.  May not be higher than the value specified by
      the server.
    </doc>
        <rule implement="MAY">
      The server MAY ignore the channel-max value or MAY use it for
      tuning its resource allocation.
    </rule>
        <assert check="notnull"/>
        <assert check="le" method="tune" field="channel max"/>
      </field>
      <field name="frame max" type="long">
    negotiated maximum frame size
    <doc>
      The largest frame size that the client and server will use for
      the connection.  Zero means that the client does not impose any
      specific limit but may reject very large frames if it cannot
      allocate resources for them.  Note that the frame-max limit
      applies principally to content frames, where large contents
      can be broken into frames of arbitrary size.
    </doc>
        <rule implement="MUST">
      Until the frame-max has been negotiated, both peers must accept
      frames of up to 4096 octets large. The minimum non-zero value for
      the frame-max field is 4096.
    </rule>
      </field>
      <field name="heartbeat" type="short">
    desired heartbeat delay
    <doc>
      The delay, in seconds, of the connection heartbeat that the client
      wants. Zero means the client does not want a heartbeat.
    </doc>
      </field>
    </method>
    <!-- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -->
    <method name="open" synchronous="1" index="40">
  open connection to virtual host
  <doc>
    This method opens a connection to a virtual host, which is a
    collection of resources, and acts to separate multiple application
    domains within a server.
  </doc>
      <rule implement="MUST">
    The client MUST open the context before doing any work on the
    connection.
  </rule>
      <chassis name="server" implement="MUST"/>
      <response name="open-ok"/>
      <response name="redirect"/>
      <field name="virtual host" domain="path">
    virtual host name
    <assert check="regexp" value="^[a-zA-Z0-9/-_]+$"/>
        <doc>
      The name of the virtual host to work with.
    </doc>
        <rule implement="MUST">
      If the server supports multiple virtual hosts, it MUST enforce a
      full separation of exchanges, queues, and all associated entities
      per virtual host. An application, connected to a specific virtual
      host, MUST NOT be able to access resources of another virtual host.
    </rule>
        <rule implement="SHOULD">
      The server SHOULD verify that the client has permission to access
      the specified virtual host.
    </rule>
        <rule implement="MAY">
      The server MAY configure arbitrary limits per virtual host, such
      as the number of each type of entity that may be used, per
      connection and/or in total.
    </rule>
      </field>
      <field name="capabilities" type="shortstr">
    required capabilities
    <doc>
      The client may specify a number of capability names, delimited by
      spaces.  The server can use this string to how to process the
      client's connection request.
    </doc>
      </field>
      <field name="insist" type="bit">
    insist on connecting to server
    <doc>
      In a configuration with multiple load-sharing servers, the server
      may respond to a Connection.Open method with a Connection.Redirect.
      The insist option tells the server that the client is insisting on
      a connection to the specified server.
    </doc>
        <rule implement="SHOULD">
      When the client uses the insist option, the server SHOULD accept
      the client connection unless it is technically unable to do so.
    </rule>
      </field>
    </method>
    <method name="open-ok" synchronous="1" index="41">
  signal that the connection is ready
  <doc>
    This method signals to the client that the connection is ready for
    use.
  </doc>
      <chassis name="client" implement="MUST"/>
      <field name="known hosts" domain="known hosts"/>
    </method>
    <method name="redirect" synchronous="1" index="50">
  asks the client to use a different server
  <doc>
    This method redirects the client to another server, based on the
    requested virtual host and/or capabilities.
  </doc>
      <rule implement="SHOULD">
    When getting the Connection.Redirect method, the client SHOULD
    reconnect to the host specified, and if that host is not present,
    to any of the hosts specified in the known-hosts list.
  </rule>
      <chassis name="client" implement="MAY"/>
      <field name="host" type="shortstr">
    server to connect to
    <doc>
      Specifies the server to connect to.  This is an IP address or a
      DNS name, optionally followed by a colon and a port number. If
      no port number is specified, the client should use the default
      port number for the protocol.
    </doc>
        <assert check="notnull"/>
      </field>
      <field name="known hosts" domain="known hosts"/>
    </method>
    <!-- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -->
    <method name="close" synchronous="1" index="60">
  request a connection close
  <doc>
    This method indicates that the sender wants to close the connection.
    This may be due to internal conditions (e.g. a forced shut-down) or
    due to an error handling a specific method, i.e. an exception.  When
    a close is due to an exception, the sender provides the class and
    method id of the method which caused the exception.
  </doc>
      <rule implement="MUST">
    After sending this method any received method except the Close-OK
    method MUST be discarded.
  </rule>
      <rule implement="MAY">
    The peer sending this method MAY use a counter or timeout to
    detect failure of the other peer to respond correctly with
    the Close-OK method.
  </rule>
      <rule implement="MUST">
    When a server receives the Close method from a client it MUST
    delete all server-side resources associated with the client's
    context.  A client CANNOT reconnect to a context after sending
    or receiving a Close method.
  </rule>
      <chassis name="client" implement="MUST"/>
      <chassis name="server" implement="MUST"/>
      <response name="close-ok"/>
      <field name="reply code" domain="reply code"/>
      <field name="reply text" domain="reply text"/>
      <field name="class id" domain="class id">
    failing method class
    <doc>
      When the close is provoked by a method exception, this is the
      class of the method.
    </doc>
      </field>
      <field name="method id" domain="class id">
    failing method ID
    <doc>
      When the close is provoked by a method exception, this is the
      ID of the method.
    </doc>
      </field>
    </method>
    <method name="close-ok" synchronous="1" index="61">
  confirm a connection close
  <doc>
    This method confirms a Connection.Close method and tells the
    recipient that it is safe to release resources for the connection
    and close the socket.
  </doc>
      <rule implement="SHOULD">
    A peer that detects a socket closure without having received a
    Close-Ok handshake method SHOULD log the error.
  </rule>
      <chassis name="client" implement="MUST"/>
      <chassis name="server" implement="MUST"/>
    </method>
  </class>
  <class name="channel" handler="channel" index="20">
    <!--
======================================================
==       CHANNEL
======================================================
-->
  work with channels
<doc>
  The channel class provides methods for a client to establish a virtual
  connection - a channel - to a server and for both peers to operate the
  virtual connection thereafter.
</doc>
    <doc name="grammar">
    channel             = open-channel *use-channel close-channel
    open-channel        = C:OPEN S:OPEN-OK
    use-channel         = C:FLOW S:FLOW-OK
                        / S:FLOW C:FLOW-OK
                        / S:ALERT
                        / functional-class
    close-channel       = C:CLOSE S:CLOSE-OK
                        / S:CLOSE C:CLOSE-OK
</doc>
    <chassis name="server" implement="MUST"/>
    <chassis name="client" implement="MUST"/>
    <!-- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -->
    <method name="open" synchronous="1" index="10">
  open a channel for use
  <doc>
    This method opens a virtual connection (a channel).
  </doc>
      <rule implement="MUST">
    This method MUST NOT be called when the channel is already open.
  </rule>
      <chassis name="server" implement="MUST"/>
      <response name="open-ok"/>
      <field name="out of band" type="shortstr">
    out-of-band settings
    <doc>
      Configures out-of-band transfers on this channel.  The syntax and
      meaning of this field will be formally defined at a later date.
    </doc>
        <assert check="null"/>
      </field>
    </method>
    <method name="open-ok" synchronous="1" index="11">
  signal that the channel is ready
  <doc>
    This method signals to the client that the channel is ready for use.
  </doc>
      <chassis name="client" implement="MUST"/>
    </method>
    <!-- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -->
    <method name="flow" synchronous="1" index="20">
  enable/disable flow from peer
  <doc>
    This method asks the peer to pause or restart the flow of content
    data. This is a simple flow-control mechanism that a peer can use
    to avoid oveflowing its queues or otherwise finding itself receiving
    more messages than it can process.  Note that this method is not
    intended for window control.  The peer that receives a request to
    stop sending content should finish sending the current content, if
    any, and then wait until it receives a Flow restart method.
  </doc>
      <rule implement="MAY">
    When a new channel is opened, it is active.  Some applications
    assume that channels are inactive until started.  To emulate this
    behaviour a client MAY open the channel, then pause it.
  </rule>
      <rule implement="SHOULD">
    When sending content data in multiple frames, a peer SHOULD monitor
    the channel for incoming methods and respond to a Channel.Flow as
    rapidly as possible.
  </rule>
      <rule implement="MAY">
    A peer MAY use the Channel.Flow method to throttle incoming content
    data for internal reasons, for example, when exchangeing data over a
    slower connection.
  </rule>
      <rule implement="MAY">
    The peer that requests a Channel.Flow method MAY disconnect and/or
    ban a peer that does not respect the request.
  </rule>
      <chassis name="server" implement="MUST"/>
      <chassis name="client" implement="MUST"/>
      <response name="flow-ok"/>
      <field name="active" type="bit">
    start/stop content frames
    <doc>
      If 1, the peer starts sending content frames.  If 0, the peer
      stops sending content frames.
    </doc>
      </field>
    </method>
    <method name="flow-ok" index="21">
  confirm a flow method
  <doc>
    Confirms to the peer that a flow command was received and processed.
  </doc>
      <chassis name="server" implement="MUST"/>
      <chassis name="client" implement="MUST"/>
      <field name="active" type="bit">
    current flow setting
    <doc>
      Confirms the setting of the processed flow method: 1 means the
      peer will start sending or continue to send content frames; 0
      means it will not.
    </doc>
      </field>
    </method>
    <!-- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -->
    <method name="alert" index="30">
  send a non-fatal warning message
  <doc>
    This method allows the server to send a non-fatal warning to the
    client.  This is used for methods that are normally asynchronous
    and thus do not have confirmations, and for which the server may
    detect errors that need to be reported.  Fatal errors are handled
    as channel or connection exceptions; non-fatal errors are sent
    through this method.
  </doc>
      <chassis name="client" implement="MUST"/>
      <field name="reply code" domain="reply code"/>
      <field name="reply text" domain="reply text"/>
      <field name="details" type="table">
    detailed information for warning
    <doc>
      A set of fields that provide more information about the
      problem.  The meaning of these fields are defined on a
      per-reply-code basis (TO BE DEFINED).
    </doc>
      </field>
    </method>
    <!-- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -->
    <method name="close" synchronous="1" index="40">
  request a channel close
  <doc>
    This method indicates that the sender wants to close the channel.
    This may be due to internal conditions (e.g. a forced shut-down) or
    due to an error handling a specific method, i.e. an exception.  When
    a close is due to an exception, the sender provides the class and
    method id of the method which caused the exception.
  </doc>
      <rule implement="MUST">
    After sending this method any received method except
    Channel.Close-OK MUST be discarded.
  </rule>
      <rule implement="MAY">
    The peer sending this method MAY use a counter or timeout to detect
    failure of the other peer to respond correctly with Channel.Close-OK..
  </rule>
      <chassis name="client" implement="MUST"/>
      <chassis name="server" implement="MUST"/>
      <response name="close-ok"/>
      <field name="reply code" domain="reply code"/>
      <field name="reply text" domain="reply text"/>
      <field name="class id" domain="class id">
    failing method class
    <doc>
      When the close is provoked by a method exception, this is the
      class of the method.
    </doc>
      </field>
      <field name="method id" domain="method id">
    failing method ID
    <doc>
      When the close is provoked by a method exception, this is the
      ID of the method.
    </doc>
      </field>
    </method>
    <method name="close-ok" synchronous="1" index="41">
  confirm a channel close
  <doc>
    This method confirms a Channel.Close method and tells the recipient
    that it is safe to release resources for the channel and close the
    socket.
  </doc>
      <rule implement="SHOULD">
    A peer that detects a socket closure without having received a
    Channel.Close-Ok handshake method SHOULD log the error.
  </rule>
      <chassis name="client" implement="MUST"/>
      <chassis name="server" implement="MUST"/>
    </method>
  </class>
  <class name="access" handler="connection" index="30">
    <!--
======================================================
==      ACCESS CONTROL
======================================================
-->
  work with access tickets
<doc>
  The protocol control access to server resources using access tickets.
  A client must explicitly request access tickets before doing work.
  An access ticket grants a client the right to use a specific set of
  resources - called a "realm" - in specific ways.
</doc>
    <doc name="grammar">
    access              = C:REQUEST S:REQUEST-OK
</doc>
    <chassis name="server" implement="MUST"/>
    <chassis name="client" implement="MUST"/>
    <!-- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -->
    <method name="request" synchronous="1" index="10">
  request an access ticket
  <doc>
    This method requests an access ticket for an access realm.
    The server responds by granting the access ticket.  If the
    client does not have access rights to the requested realm
    this causes a connection exception.  Access tickets are a
    per-channel resource.
  </doc>
      <rule implement="MUST">
    The realm name MUST start with either "/data" (for application
    resources) or "/admin" (for server administration resources).
    If the realm starts with any other path, the server MUST raise
    a connection exception with reply code 403 (access refused).
  </rule>
      <rule implement="MUST">
    The server MUST implement the /data realm and MAY implement the
    /admin realm.  The mapping of resources to realms is not
    defined in the protocol - this is a server-side configuration
    issue.
  </rule>
      <chassis name="server" implement="MUST"/>
      <response name="request-ok"/>
      <field name="realm" domain="path">
    name of requested realm
    <rule implement="MUST">
      If the specified realm is not known to the server, the server
      must raise a channel exception with reply code 402 (invalid
      path).
    </rule>
      </field>
      <field name="exclusive" type="bit">
    request exclusive access
    <doc>
      Request exclusive access to the realm. If the server cannot grant
      this - because there are other active tickets for the realm - it
      raises a channel exception.
    </doc>
      </field>
      <field name="passive" type="bit">
    request passive access
    <doc>
      Request message passive access to the specified access realm.
      Passive access lets a client get information about resources in
      the realm but not to make any changes to them.
    </doc>
      </field>
      <field name="active" type="bit">
    request active access
    <doc>
      Request message active access to the specified access realm.
      Acvtive access lets a client get create and delete resources in
      the realm.
    </doc>
      </field>
      <field name="write" type="bit">
    request write access
    <doc>
      Request write access to the specified access realm.  Write access
      lets a client publish messages to all exchanges in the realm.
    </doc>
      </field>
      <field name="read" type="bit">
    request read access
    <doc>
      Request read access to the specified access realm.  Read access
      lets a client consume messages from queues in the realm.
    </doc>
      </field>
    </method>
    <method name="request-ok" synchronous="1" index="11">
  grant access to server resources
  <doc>
    This method provides the client with an access ticket. The access
    ticket is valid within the current channel and for the lifespan of
    the channel.
  </doc>
      <rule implement="MUST">
    The client MUST NOT use access tickets except within the same
    channel as originally granted.
  </rule>
      <rule implement="MUST">
    The server MUST isolate access tickets per channel and treat an
    attempt by a client to mix these as a connection exception.
  </rule>
      <chassis name="client" implement="MUST"/>
      <field name="ticket" domain="access ticket"/>
    </method>
  </class>
  <class name="exchange" handler="channel" index="40">
    <!--
======================================================
==       EXCHANGES (or "routers", if you prefer)
==       (Or matchers, plugins, extensions, agents,... Routing is just one of
==        the many fun things an exchange can do.)
======================================================
-->
  work with exchanges
<doc>
  Exchanges match and distribute messages across queues.  Exchanges can be
  configured in the server or created at runtime.
</doc>
    <doc name="grammar">
    exchange            = C:DECLARE  S:DECLARE-OK
                        / C:DELETE   S:DELETE-OK
</doc>
    <chassis name="server" implement="MUST"/>
    <chassis name="client" implement="MUST"/>
    <rule implement="MUST">
      <test>amq_exchange_19</test>
  The server MUST implement the direct and fanout exchange types, and
  predeclare the corresponding exchanges named amq.direct and amq.fanout
  in each virtual host. The server MUST also predeclare a direct
  exchange to act as the default exchange for content Publish methods
  and for default queue bindings.
</rule>
    <rule implement="SHOULD">
      <test>amq_exchange_20</test>
  The server SHOULD implement the topic exchange type, and predeclare
  the corresponding exchange named amq.topic in each virtual host.
</rule>
    <rule implement="MAY">
      <test>amq_exchange_21</test>
  The server MAY implement the system exchange type, and predeclare the
  corresponding exchanges named amq.system in each virtual host. If the
  client attempts to bind a queue to the system exchange, the server
  MUST raise a connection exception with reply code 507 (not allowed).
</rule>
    <rule implement="MUST">
      <test>amq_exchange_22</test>
  The default exchange MUST be defined as internal, and be inaccessible
  to the client except by specifying an empty exchange name in a content
  Publish method. That is, the server MUST NOT let clients make explicit
  bindings to this exchange.
</rule>
    <!-- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -->
    <method name="declare" synchronous="1" index="10">
  declare exchange, create if needed
  <doc>
    This method creates an exchange if it does not already exist, and if the
    exchange exists, verifies that it is of the correct and expected class.
  </doc>
      <rule implement="SHOULD">
        <test>amq_exchange_23</test>
    The server SHOULD support a minimum of 16 exchanges per virtual host
    and ideally, impose no limit except as defined by available resources.
  </rule>
      <chassis name="server" implement="MUST"/>
      <response name="declare-ok"/>
      <field name="ticket" domain="access ticket">
        <doc>
      When a client defines a new exchange, this belongs to the access realm
      of the ticket used.  All further work done with that exchange must be
      done with an access ticket for the same realm.
    </doc>
        <rule implement="MUST">
      The client MUST provide a valid access ticket giving "active" access
      to the realm in which the exchange exists or will be created, or
      "passive" access if the if-exists flag is set.
    </rule>
      </field>
      <field name="exchange" domain="exchange name">
        <rule implement="MUST">
          <test>amq_exchange_15</test>
      Exchange names starting with "amq." are reserved for predeclared
      and standardised exchanges.  If the client attempts to create an
      exchange starting with "amq.", the server MUST raise a channel
      exception with reply code 403 (access refused).
    </rule>
        <assert check="regexp" value="^[a-zA-Z0-9-_.:]+$"/>
      </field>
      <field name="type" type="shortstr">
    exchange type
    <doc>
      Each exchange belongs to one of a set of exchange types implemented
      by the server.  The exchange types define the functionality of the
      exchange - i.e. how messages are routed through it.  It is not valid
      or meaningful to attempt to change the type of an existing exchange.
    </doc>
        <rule implement="MUST">
          <test>amq_exchange_16</test>
      If the exchange already exists with a different type, the server
      MUST raise a connection exception with a reply code 507 (not allowed).
    </rule>
        <rule implement="MUST">
          <test>amq_exchange_18</test>
      If the server does not support the requested exchange type it MUST
      raise a connection exception with a reply code 503 (command invalid).
    </rule>
        <assert check="regexp" value="^[a-zA-Z0-9-_.:]+$"/>
      </field>
      <field name="passive" type="bit">
    do not create exchange
    <doc>
    If set, the server will not create the exchange.  The client can use
    this to check whether an exchange exists without modifying the server
    state.
    </doc>
        <rule implement="MUST">
          <test>amq_exchange_05</test>
      If set, and the exchange does not already exist, the server MUST
      raise a channel exception with reply code 404 (not found).
    </rule>
      </field>
      <field name="durable" type="bit">
    request a durable exchange
    <doc>
      If set when creating a new exchange, the exchange will be marked as
      durable.  Durable exchanges remain active when a server restarts.
      Non-durable exchanges (transient exchanges) are purged if/when a
      server restarts.
    </doc>
        <rule implement="MUST">
          <test>amq_exchange_24</test>
      The server MUST support both durable and transient exchanges.
    </rule>
        <rule implement="MUST">
      The server MUST ignore the durable field if the exchange already
      exists.
    </rule>
      </field>
      <field name="auto delete" type="bit">
    auto-delete when unused
    <doc>
      If set, the exchange is deleted when all queues have finished
      using it.
    </doc>
        <rule implement="SHOULD">
          <test>amq_exchange_02</test>
      The server SHOULD allow for a reasonable delay between the point
      when it determines that an exchange is not being used (or no longer
      used), and the point when it deletes the exchange.  At the least it
      must allow a client to create an exchange and then bind a queue to
      it, with a small but non-zero delay between these two actions.
    </rule>
        <rule implement="MUST">
          <test>amq_exchange_25</test>
      The server MUST ignore the auto-delete field if the exchange already
      exists.
    </rule>
      </field>
      <field name="internal" type="bit">
    create internal exchange
    <doc>
      If set, the exchange may not be used directly by publishers, but
      only when bound to other exchanges. Internal exchanges are used to
      construct wiring that is not visible to applications.
    </doc>
      </field>

  <field name = "nowait" type = "bit">
    do not send a reply method
    <doc>
    If set, the server will not respond to the method. The client should
    not wait for a reply method.  If the server could not complete the
    method it will raise a channel or connection exception.
    </doc>
  </field>

      <field name="arguments" type="table">
    arguments for declaration
    <doc>
      A set of arguments for the declaration. The syntax and semantics
      of these arguments depends on the server implementation.  This
      field is ignored if passive is 1.
    </doc>
      </field>
    </method>
    <method name="declare-ok" synchronous="1" index="11">
  confirms an exchange declaration
  <doc>
    This method confirms a Declare method and confirms the name of the
    exchange, essential for automatically-named exchanges.
  </doc>
      <chassis name="client" implement="MUST"/>
    </method>
    <!-- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -->
    <method name="delete" synchronous="1" index="20">
  delete an exchange
  <doc>
    This method deletes an exchange.  When an exchange is deleted all queue
    bindings on the exchange are cancelled.
  </doc>
      <chassis name="server" implement="MUST"/>
      <response name="delete-ok"/>
      <field name="ticket" domain="access ticket">
        <rule implement="MUST">
      The client MUST provide a valid access ticket giving "active"
      access rights to the exchange's access realm.
    </rule>
      </field>
      <field name="exchange" domain="exchange name">
        <rule implement="MUST">
          <test>amq_exchange_11</test>
      The exchange MUST exist. Attempting to delete a non-existing exchange
      causes a channel exception.
    </rule>
        <assert check="notnull"/>
      </field>
      <field name="if unused" type="bit">
    delete only if unused
    <doc>
      If set, the server will only delete the exchange if it has no queue
      bindings. If the exchange has queue bindings the server does not
      delete it but raises a channel exception instead.
    </doc>
        <rule implement="SHOULD">
          <test>amq_exchange_12</test>
      If set, the server SHOULD delete the exchange but only if it has
      no queue bindings.
    </rule>
        <rule implement="SHOULD">
          <test>amq_exchange_13</test>
      If set, the server SHOULD raise a channel exception if the exchange is in
      use.
    </rule>
      </field>

  <field name = "nowait" type = "bit">
    do not send a reply method
    <doc>
    If set, the server will not respond to the method. The client should
    not wait for a reply method.  If the server could not complete the
    method it will raise a channel or connection exception.
    </doc>
  </field>

    </method>
    <method name="delete-ok" synchronous="1" index="21">
  confirm deletion of an exchange
  <doc>
    This method confirms the deletion of an exchange.
  </doc>
      <chassis name="client" implement="MUST"/>
    </method>
  </class>
  <class name="queue" handler="channel" index="50">
    <!--
======================================================
==       QUEUES
======================================================
-->
  work with queues

<doc>
  Queues store and forward messages.  Queues can be configured in the server
  or created at runtime.  Queues must be attached to at least one exchange
  in order to receive messages from publishers.
</doc>
    <doc name="grammar">
    queue               = C:DECLARE  S:DECLARE-OK
                        / C:BIND     S:BIND-OK
                        / C:PURGE    S:PURGE-OK
                        / C:DELETE   S:DELETE-OK
</doc>
    <chassis name="server" implement="MUST"/>
    <chassis name="client" implement="MUST"/>
    <rule implement="MUST">
      <test>amq_queue_33</test>
  A server MUST allow any content class to be sent to any queue, in any
  mix, and queue and delivery these content classes independently. Note
  that all methods that fetch content off queues are specific to a given
  content class.
</rule>
    <!-- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -->
    <method name="declare" synchronous="1" index="10">
  declare queue, create if needed
  <doc>
    This method creates or checks a queue.  When creating a new queue
    the client can specify various properties that control the durability
    of the queue and its contents, and the level of sharing for the queue.
  </doc>
      <rule implement="MUST">
        <test>amq_queue_34</test>
    The server MUST create a default binding for a newly-created queue
    to the default exchange, which is an exchange of type 'direct'.
  </rule>
      <rule implement="SHOULD">
        <test>amq_queue_35</test>
    The server SHOULD support a minimum of 256 queues per virtual host
    and ideally, impose no limit except as defined by available resources.
  </rule>
      <chassis name="server" implement="MUST"/>
      <response name="declare-ok"/>
      <field name="ticket" domain="access ticket">
        <doc>
      When a client defines a new queue, this belongs to the access realm
      of the ticket used.  All further work done with that queue must be
      done with an access ticket for the same realm.
    </doc>
        <doc>
      The client provides a valid access ticket giving "active" access
      to the realm in which the queue exists or will be created, or
      "passive" access if the if-exists flag is set.
    </doc>
      </field>
      <field name="queue" domain="queue name">
        <rule implement="MAY">
          <test>amq_queue_10</test>
      The queue name MAY be empty, in which case the server MUST create
      a new queue with a unique generated name and return this to the
      client in the Declare-Ok method.
    </rule>
        <rule implement="MUST">
          <test>amq_queue_32</test>
      Queue names starting with "amq." are reserved for predeclared and
      standardised server queues.  If the queue name starts with "amq."
      and the passive option is zero, the server MUST raise a connection
      exception with reply code 403 (access refused).
    </rule>
        <assert check="regexp" value="^[a-zA-Z0-9-_.:]*$"/>
      </field>
      <field name="passive" type="bit">
    do not create queue
    <doc>
    If set, the server will not create the queue.  The client can use
    this to check whether a queue exists without modifying the server
    state.
    </doc>
        <rule implement="MUST">
          <test>amq_queue_05</test>
      If set, and the queue does not already exist, the server MUST
      respond with a reply code 404 (not found) and raise a channel
      exception.
    </rule>
      </field>
      <field name="durable" type="bit">
    request a durable queue
    <doc>
      If set when creating a new queue, the queue will be marked as
      durable.  Durable queues remain active when a server restarts.
      Non-durable queues (transient queues) are purged if/when a
      server restarts.  Note that durable queues do not necessarily
      hold persistent messages, although it does not make sense to
      send persistent messages to a transient queue.
    </doc>
        <rule implement="MUST">
          <test>amq_queue_03</test>
      The server MUST recreate the durable queue after a restart.
    </rule>
        <rule implement="MUST">
          <test>amq_queue_36</test>
      The server MUST support both durable and transient queues.
    </rule>
        <rule implement="MUST">
          <test>amq_queue_37</test>
      The server MUST ignore the durable field if the queue already
      exists.
    </rule>
      </field>
      <field name="exclusive" type="bit">
    request an exclusive queue
    <doc>
      Exclusive queues may only be consumed from by the current connection.
      Setting the 'exclusive' flag always implies 'auto-delete'.
    </doc>
        <rule implement="MUST">
          <test>amq_queue_38</test>
      The server MUST support both exclusive (private) and non-exclusive
      (shared) queues.
    </rule>
        <rule implement="MUST">
          <test>amq_queue_04</test>
      The server MUST raise a channel exception if 'exclusive' is specified
      and the queue already exists and is owned by a different connection.
    </rule>
      </field>
      <field name="auto delete" type="bit">
    auto-delete queue when unused
    <doc>
      If set, the queue is deleted when all consumers have finished
      using it. Last consumer can be cancelled either explicitly or because
      its channel is closed. If there was no consumer ever on the queue, it
      won't be deleted.
    </doc>
        <rule implement="SHOULD">
          <test>amq_queue_02</test>
      The server SHOULD allow for a reasonable delay between the point
      when it determines that a queue is not being used (or no longer
      used), and the point when it deletes the queue.  At the least it
      must allow a client to create a queue and then create a consumer
      to read from it, with a small but non-zero delay between these
      two actions.  The server should equally allow for clients that may
      be disconnected prematurely, and wish to re-consume from the same
      queue without losing messages.  We would recommend a configurable
      timeout, with a suitable default value being one minute.
    </rule>
        <rule implement="MUST">
          <test>amq_queue_31</test>
      The server MUST ignore the auto-delete field if the queue already
      exists.
    </rule>
      </field>
  <field name = "nowait" type = "bit">
    do not send a reply method
    <doc>
    If set, the server will not respond to the method. The client should
    not wait for a reply method.  If the server could not complete the
    method it will raise a channel or connection exception.
    </doc>
  </field>

      <field name="arguments" type="table">
    arguments for declaration
    <doc>
      A set of arguments for the declaration. The syntax and semantics
      of these arguments depends on the server implementation.  This
      field is ignored if passive is 1.
    </doc>
      </field>
    </method>
    <method name="declare-ok" synchronous="1" index="11">
  confirms a queue definition
  <doc>
    This method confirms a Declare method and confirms the name of the
    queue, essential for automatically-named queues.
  </doc>
      <chassis name="client" implement="MUST"/>
      <field name="queue" domain="queue name">
        <doc>
      Reports the name of the queue. If the server generated a queue
      name, this field contains that name.
    </doc>
        <assert check="notnull"/>
      </field>
      <field name="message count" type="long">
    number of messages in queue
    <doc>
      Reports the number of messages in the queue, which will be zero
      for newly-created queues.
    </doc>
      </field>
      <field name="consumer count" type="long">
    number of consumers
    <doc>
      Reports the number of active consumers for the queue. Note that
      consumers can suspend activity (Channel.Flow) in which case they
      do not appear in this count.
    </doc>
      </field>
    </method>
    <!-- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -->
    <method name="bind" synchronous="1" index="20">
  bind queue to an exchange
  <doc>
    This method binds a queue to an exchange.  Until a queue is
    bound it will not receive any messages.  In a classic messaging
    model, store-and-forward queues are bound to a dest exchange
    and subscription queues are bound to a dest_wild exchange.
  </doc>
      <rule implement="MUST">
        <test>amq_queue_25</test>
    A server MUST allow ignore duplicate bindings - that is, two or
    more bind methods for a specific queue, with identical arguments
    - without treating these as an error.
  </rule>
      <rule implement="MUST">
        <test>amq_queue_39</test>
    If a bind fails, the server MUST raise a connection exception.
  </rule>
      <rule implement="MUST">
        <test>amq_queue_12</test>
    The server MUST NOT allow a durable queue to bind to a transient
    exchange. If the client attempts this the server MUST raise a
    channel exception.
  </rule>
      <rule implement="SHOULD">
        <test>amq_queue_13</test>
    Bindings for durable queues are automatically durable and the
    server SHOULD restore such bindings after a server restart.
  </rule>
      <rule implement="MUST">
        <test>amq_queue_17</test>
    If the client attempts to an exchange that was declared as internal,
    the server MUST raise a connection exception with reply code 530
    (not allowed).
  </rule>
      <rule implement="SHOULD">
        <test>amq_queue_40</test>
    The server SHOULD support at least 4 bindings per queue, and
    ideally, impose no limit except as defined by available resources.
  </rule>
      <chassis name="server" implement="MUST"/>
      <response name="bind-ok"/>
      <field name="ticket" domain="access ticket">
        <doc>
      The client provides a valid access ticket giving "active"
      access rights to the queue's access realm.
    </doc>
      </field>

  <field name = "queue" domain = "queue name">
    <doc>
      Specifies the name of the queue to bind.  If the queue name is
      empty, refers to the current queue for the channel, which is
      the last declared queue.
    </doc>
    <doc name = "rule">
      If the client did not previously declare a queue, and the queue
      name in this method is empty, the server MUST raise a connection
      exception with reply code 530 (not allowed).
    </doc>
    <doc name = "rule" test = "amq_queue_26">
      If the queue does not exist the server MUST raise a channel exception
      with reply code 404 (not found).
    </doc>
  </field>

  <field name="exchange" domain="exchange name">
          The name of the exchange to bind to.
          <rule implement="MUST">
          <test>amq_queue_14</test>
      If the exchange does not exist the server MUST raise a channel
      exception with reply code 404 (not found).
    </rule>
      </field>
      <field name="routing key" type="shortstr">
     message routing key
    <doc>
      Specifies the routing key for the binding.  The routing key is
      used for routing messages depending on the exchange configuration.
      Not all exchanges use a routing key - refer to the specific
      exchange documentation.  If the routing key is empty and the queue
      name is empty, the routing key will be the current queue for the
      channel, which is the last declared queue.
    </doc>
  </field>

  <field name = "nowait" type = "bit">
    do not send a reply method
    <doc>
    If set, the server will not respond to the method. The client should
    not wait for a reply method.  If the server could not complete the
    method it will raise a channel or connection exception.
    </doc>
  </field>

  <field name="arguments" type="table">
    arguments for binding
    <doc>
      A set of arguments for the binding.  The syntax and semantics of
      these arguments depends on the exchange class.
    </doc>
      </field>
    </method>
    <method name="bind-ok" synchronous="1" index="21">
  confirm bind successful
  <doc>
    This method confirms that the bind was successful.
  </doc>
      <chassis name="client" implement="MUST"/>
    </method>
    <!-- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -->
    <method name="purge" synchronous="1" index="30">
  purge a queue
  <doc>
    This method removes all messages from a queue.  It does not cancel
    consumers.  Purged messages are deleted without any formal "undo"
    mechanism.
  </doc>
      <rule implement="MUST">
        <test>amq_queue_15</test>
    A call to purge MUST result in an empty queue.
  </rule>
      <rule implement="MUST">
        <test>amq_queue_41</test>
    On transacted channels the server MUST not purge messages that have
    already been sent to a client but not yet acknowledged.
  </rule>
      <rule implement="MAY">
        <test>amq_queue_42</test>
    The server MAY implement a purge queue or log that allows system
    administrators to recover accidentally-purged messages.  The server
    SHOULD NOT keep purged messages in the same storage spaces as the
    live messages since the volumes of purged messages may get very
    large.
  </rule>
      <chassis name="server" implement="MUST"/>
      <response name="purge-ok"/>
      <field name="ticket" domain="access ticket">
        <doc>
      The access ticket must be for the access realm that holds the
      queue.
    </doc>
        <rule implement="MUST">
      The client MUST provide a valid access ticket giving "read" access
      rights to the queue's access realm.  Note that purging a queue is
      equivalent to reading all messages and discarding them.
    </rule>
      </field>
  <field name = "queue" domain = "queue name">
    <doc>
      Specifies the name of the queue to purge.  If the queue name is
      empty, refers to the current queue for the channel, which is
      the last declared queue.
    </doc>
    <doc name = "rule">
      If the client did not previously declare a queue, and the queue
      name in this method is empty, the server MUST raise a connection
      exception with reply code 530 (not allowed).
    </doc>
    <doc name = "rule" test = "amq_queue_16">
      The queue must exist. Attempting to purge a non-existing queue
      causes a channel exception.
    </doc>
  </field>

  <field name = "nowait" type = "bit">
    do not send a reply method
    <doc>
    If set, the server will not respond to the method. The client should
    not wait for a reply method.  If the server could not complete the
    method it will raise a channel or connection exception.
    </doc>
  </field>
    </method>
    <method name="purge-ok" synchronous="1" index="31">
  confirms a queue purge
  <doc>
    This method confirms the purge of a queue.
  </doc>
      <chassis name="client" implement="MUST"/>
      <field name="message count" type="long">
    number of messages purged
    <doc>
      Reports the number of messages purged.
    </doc>
      </field>
    </method>
    <!-- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -->
    <method name="delete" synchronous="1" index="40">
  delete a queue
  <doc>
    This method deletes a queue.  When a queue is deleted any pending
    messages are sent to a dead-letter queue if this is defined in the
    server configuration, and all consumers on the queue are cancelled.
  </doc>
      <rule implement="SHOULD">
        <test>amq_queue_43</test>
    The server SHOULD use a dead-letter queue to hold messages that
    were pending on a deleted queue, and MAY provide facilities for
    a system administrator to move these messages back to an active
    queue.
  </rule>
      <chassis name="server" implement="MUST"/>
      <response name="delete-ok"/>
      <field name="ticket" domain="access ticket">
        <doc>
      The client provides a valid access ticket giving "active"
      access rights to the queue's access realm.
    </doc>
      </field>

  <field name = "queue" domain = "queue name">
    <doc>
      Specifies the name of the queue to delete. If the queue name is
      empty, refers to the current queue for the channel, which is the
      last declared queue.
    </doc>
    <doc name = "rule">
      If the client did not previously declare a queue, and the queue
      name in this method is empty, the server MUST raise a connection
      exception with reply code 530 (not allowed).
    </doc>
    <doc name = "rule" test = "amq_queue_21">
      The queue must exist. Attempting to delete a non-existing queue
      causes a channel exception.
    </doc>
  </field>

      <field name="if unused" type="bit">
    delete only if unused
    <doc>
      If set, the server will only delete the queue if it has no
      consumers. If the queue has consumers the server does does not
      delete it but raises a channel exception instead.
    </doc>
        <rule implement="MUST">
          <test>amq_queue_29</test>
          <test>amq_queue_30</test>
      The server MUST respect the if-unused flag when deleting a queue.
    </rule>
      </field>
      <field name="if empty" type="bit">
    delete only if empty
        <test>amq_queue_27</test>
        <doc>
      If set, the server will only delete the queue if it has no
      messages. If the queue is not empty the server raises a channel
      exception.
    </doc>
      </field>
  <field name = "nowait" type = "bit">
    do not send a reply method
    <doc>
    If set, the server will not respond to the method. The client should
    not wait for a reply method.  If the server could not complete the
    method it will raise a channel or connection exception.
    </doc>
  </field>
    </method>

    <method name="delete-ok" synchronous="1" index="41">
  confirm deletion of a queue
  <doc>
    This method confirms the deletion of a queue.
  </doc>
      <chassis name="client" implement="MUST"/>
      <field name="message count" type="long">
    number of messages purged
    <doc>
      Reports the number of messages purged.
    </doc>
      </field>
    </method>
  </class>
  <class name="basic" handler="channel" index="60">
    <!--
======================================================
==       BASIC MIDDLEWARE
======================================================
-->
  work with basic content
<doc>
  The Basic class provides methods that support an industry-standard
  messaging model.
</doc>

<doc name = "grammar">
    basic               = C:QOS S:QOS-OK
                        / C:CONSUME S:CONSUME-OK
                        / C:CANCEL S:CANCEL-OK
                        / C:PUBLISH content
                        / S:RETURN content
                        / S:DELIVER content
                        / C:GET ( S:GET-OK content / S:GET-EMPTY )
                        / C:ACK
                        / C:REJECT
</doc>

<chassis name = "server" implement = "MUST" />
<chassis name = "client" implement = "MAY"  />

<doc name = "rule" test = "amq_basic_08">
  The server SHOULD respect the persistent property of basic messages
  and SHOULD make a best-effort to hold persistent basic messages on a
  reliable storage mechanism.
</doc>
<doc name = "rule" test = "amq_basic_09">
  The server MUST NOT discard a persistent basic message in case of a
  queue overflow. The server MAY use the Channel.Flow method to slow
  or stop a basic message publisher when necessary.
</doc>
<doc name = "rule" test = "amq_basic_10">
  The server MAY overflow non-persistent basic messages to persistent
  storage and MAY discard or dead-letter non-persistent basic messages
  on a priority basis if the queue size exceeds some configured limit.
</doc>
<doc name = "rule" test = "amq_basic_11">
  The server MUST implement at least 2 priority levels for basic
  messages, where priorities 0-4 and 5-9 are treated as two distinct
  levels. The server MAY implement up to 10 priority levels.
</doc>
<doc name = "rule" test = "amq_basic_12">
  The server MUST deliver messages of the same priority in order
  irrespective of their individual persistence.
</doc>
<doc name = "rule" test = "amq_basic_13">
  The server MUST support both automatic and explicit acknowledgements
  on Basic content.
</doc>

<!--  These are the properties for a Basic content  -->

<field name = "content type" type = "shortstr">
    MIME content type
</field>
<field name = "content encoding" type = "shortstr">
    MIME content encoding
</field>
<field name = "headers" type = "table">
    Message header field table
</field>
<field name = "delivery mode" type = "octet">
    Non-persistent (1) or persistent (2)
</field>
<field name = "priority" type = "octet">
    The message priority, 0 to 9
</field>
<field name = "correlation id" type = "shortstr">
    The application correlation identifier
</field>
<field name = "reply to" type = "shortstr">
    The destination to reply to
</field>
<field name = "expiration" type = "shortstr">
    Message expiration specification
</field>
<field name = "message id" type = "shortstr">
    The application message identifier
</field>
<field name = "timestamp" type = "timestamp">
    The message timestamp
</field>
<field name = "type" type = "shortstr">
    The message type name
</field>
<field name = "user id" type = "shortstr">
    The creating user id
</field>
<field name = "app id" type = "shortstr">
    The creating application id
</field>
<field name = "cluster id" type = "shortstr">
    Intra-cluster routing identifier
</field>


<!-- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -->

<method name = "qos" synchronous = "1" index = "10">
  specify quality of service
  <doc>
    This method requests a specific quality of service.  The QoS can
    be specified for the current channel or for all channels on the
    connection.  The particular properties and semantics of a qos method
    always depend on the content class semantics.  Though the qos method
    could in principle apply to both peers, it is currently meaningful
    only for the server.
  </doc>
  <chassis name = "server" implement = "MUST" />
  <response name = "qos-ok" />

  <field name = "prefetch size" type = "long">
    prefetch window in octets
    <doc>
      The client can request that messages be sent in advance so that
      when the client finishes processing a message, the following
      message is already held locally, rather than needing to be sent
      down the channel.  Prefetching gives a performance improvement.
      This field specifies the prefetch window size in octets.  The
      server will send a message in advance if it is equal to or
      smaller in size than the available prefetch size (and also falls
      into other prefetch limits). May be set to zero, meaning "no
      specific limit", although other prefetch limits may still apply.
      The prefetch-size is ignored if the no-ack option is set.
    </doc>
    <doc name = "rule" test = "amq_basic_17">
      The server MUST ignore this setting when the client is not
      processing any messages - i.e. the prefetch size does not limit
      the transfer of single messages to a client, only the sending in
      advance of more messages while the client still has one or more
      unacknowledged messages.
   </doc>
  </field>

  <field name = "prefetch count" type = "short">
    prefetch window in messages
    <doc>
      Specifies a prefetch window in terms of whole messages.  This
      field may be used in combination with the prefetch-size field;
      a message will only be sent in advance if both prefetch windows
      (and those at the channel and connection level) allow it.
      The prefetch-count is ignored if the no-ack option is set.
    </doc>
    <doc name = "rule" test = "amq_basic_18">
      The server MAY send less data in advance than allowed by the
      client's specified prefetch windows but it MUST NOT send more.
    </doc>
  </field>

  <field name = "global" type = "bit">
    apply to entire connection
    <doc>
      By default the QoS settings apply to the current channel only.  If
      this field is set, they are applied to the entire connection.
    </doc>
  </field>
</method>

<method name = "qos-ok" synchronous = "1" index = "11">
  confirm the requested qos
  <doc>
    This method tells the client that the requested QoS levels could
    be handled by the server.  The requested QoS applies to all active
    consumers until a new QoS is defined.
  </doc>
  <chassis name = "client" implement = "MUST" />
</method>

<!-- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -->

<method name = "consume" synchronous = "1" index = "20">
  start a queue consumer
  <doc>
    This method asks the server to start a "consumer", which is a
    transient request for messages from a specific queue. Consumers
    last as long as the channel they were created on, or until the
    client cancels them.
  </doc>
  <doc name = "rule" test = "amq_basic_01">
    The server SHOULD support at least 16 consumers per queue, unless
    the queue was declared as private, and ideally, impose no limit
    except as defined by available resources.
  </doc>
  <chassis name = "server" implement = "MUST" />
  <response name = "consume-ok" />

  <field name = "ticket" domain = "access ticket">
    <doc name = "rule">
      The client MUST provide a valid access ticket giving "read" access
      rights to the realm for the queue.
    </doc>
  </field>

  <field name = "queue" domain = "queue name">
    <doc>
      Specifies the name of the queue to consume from.  If the queue name
      is null, refers to the current queue for the channel, which is the
      last declared queue.
    </doc>
    <doc name = "rule">
      If the client did not previously declare a queue, and the queue name
      in this method is empty, the server MUST raise a connection exception
      with reply code 530 (not allowed).
    </doc>
  </field>

  <field name = "consumer tag" domain = "consumer tag">
    <doc>
      Specifies the identifier for the consumer. The consumer tag is
      local to a connection, so two clients can use the same consumer
      tags. If this field is empty the server will generate a unique
      tag.
    </doc>
    <doc name = "rule" test = "todo">
      The tag MUST NOT refer to an existing consumer. If the client
      attempts to create two consumers with the same non-empty tag
      the server MUST raise a connection exception with reply code
      530 (not allowed).
    </doc>
  </field>

  <field name = "no local" domain = "no local" />

  <field name = "no ack" domain = "no ack" />

  <field name = "exclusive" type = "bit">
    request exclusive access
    <doc>
      Request exclusive consumer access, meaning only this consumer can
      access the queue.
    </doc>
    <doc name = "rule" test = "amq_basic_02">
      If the server cannot grant exclusive access to the queue when asked,
      - because there are other consumers active - it MUST raise a channel
      exception with return code 403 (access refused).
    </doc>
  </field>

  <field name = "nowait" type = "bit">
    do not send a reply method
    <doc>
    If set, the server will not respond to the method. The client should
    not wait for a reply method.  If the server could not complete the
    method it will raise a channel or connection exception.
    </doc>
  </field>
</method>

<method name = "consume-ok" synchronous = "1" index = "21">
  confirm a new consumer
  <doc>
    The server provides the client with a consumer tag, which is used
    by the client for methods called on the consumer at a later stage.
  </doc>
  <chassis name = "client" implement = "MUST" />

  <field name = "consumer tag" domain = "consumer tag">
    <doc>
      Holds the consumer tag specified by the client or provided by
      the server.
    </doc>
  </field>
</method>


<!-- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -->

<method name = "cancel" synchronous = "1" index = "30">
  end a queue consumer
  <doc test = "amq_basic_04">
    This method cancels a consumer. This does not affect already
    delivered messages, but it does mean the server will not send any
    more messages for that consumer.  The client may receive an
    abitrary number of messages in between sending the cancel method
    and receiving the cancel-ok reply.
  </doc>
  <doc name = "rule" test = "todo">
    If the queue no longer exists when the client sends a cancel command,
    or the consumer has been cancelled for other reasons, this command
    has no effect.
  </doc>
  <chassis name = "server" implement = "MUST" />
  <response name = "cancel-ok" />

  <field name = "consumer tag" domain = "consumer tag" />

  <field name = "nowait" type = "bit">
    do not send a reply method
    <doc>
    If set, the server will not respond to the method. The client should
    not wait for a reply method.  If the server could not complete the
    method it will raise a channel or connection exception.
    </doc>
  </field>
</method>

<method name = "cancel-ok" synchronous = "1" index = "31">
  confirm a cancelled consumer
  <doc>
    This method confirms that the cancellation was completed.
  </doc>
  <chassis name = "client" implement = "MUST" />

  <field name = "consumer tag" domain = "consumer tag" />
</method>


<!-- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -->

<method name = "publish" content = "1" index = "40">
  publish a message
  <doc>
    This method publishes a message to a specific exchange. The message
    will be routed to queues as defined by the exchange configuration
    and distributed to any active consumers when the transaction, if any,
    is committed.
  </doc>
  <chassis name = "server" implement = "MUST" />

  <field name = "ticket" domain = "access ticket">
    <doc name = "rule">
      The client MUST provide a valid access ticket giving "write"
      access rights to the access realm for the exchange.
    </doc>
  </field>

  <field name = "exchange" domain = "exchange name">
    <doc>
      Specifies the name of the exchange to publish to.  The exchange
      name can be empty, meaning the default exchange.  If the exchange
      name is specified, and that exchange does not exist, the server
      will raise a channel exception.
    </doc>
    <doc name = "rule" test = "amq_basic_06">
      The server MUST accept a blank exchange name to mean the default
      exchange.
    </doc>
    <doc name = "rule" test = "amq_basic_14">
      If the exchange was declared as an internal exchange, the server
      MUST raise a channel exception with a reply code 403 (access
      refused).
    </doc>
    <doc name = "rule" test = "amq_basic_15">
      The exchange MAY refuse basic content in which case it MUST raise
      a channel exception with reply code 540 (not implemented).
    </doc>
  </field>

  <field name = "routing key" type = "shortstr">
     Message routing key
    <doc>
      Specifies the routing key for the message.  The routing key is
      used for routing messages depending on the exchange configuration.
    </doc>
  </field>

  <field name = "mandatory" type = "bit">
    indicate mandatory routing
    <doc>
      This flag tells the server how to react if the message cannot be
      routed to a queue.  If this flag is set, the server will return an
      unroutable message with a Return method.  If this flag is zero, the
      server silently drops the message.
    </doc>
    <doc name = "rule" test = "amq_basic_07">
      The server SHOULD implement the mandatory flag.
    </doc>
  </field>

  <field name = "immediate" type = "bit">
    request immediate delivery
    <doc>
      This flag tells the server how to react if the message cannot be
      routed to a queue consumer immediately.  If this flag is set, the
      server will return an undeliverable message with a Return method.
      If this flag is zero, the server will queue the message, but with
      no guarantee that it will ever be consumed.
    </doc>
    <doc name = "rule" test = "amq_basic_16">
      The server SHOULD implement the immediate flag.
    </doc>
  </field>
</method>

<method name = "return" content = "1" index = "50">
  return a failed message
  <doc>
    This method returns an undeliverable message that was published
    with the "immediate" flag set, or an unroutable message published
    with the "mandatory" flag set. The reply code and text provide
    information about the reason that the message was undeliverable.
  </doc>
  <chassis name = "client" implement = "MUST" />

  <field name = "reply code" domain = "reply code" />
  <field name = "reply text" domain = "reply text" />

  <field name = "exchange" domain = "exchange name">
    <doc>
      Specifies the name of the exchange that the message was
      originally published to.
    </doc>
  </field>

  <field name = "routing key" type = "shortstr">
     Message routing key
    <doc>
      Specifies the routing key name specified when the message was
      published.
    </doc>
  </field>
</method>


<!-- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -->

<method name = "deliver" content = "1" index = "60">
  notify the client of a consumer message
  <doc>
    This method delivers a message to the client, via a consumer.  In
    the asynchronous message delivery model, the client starts a
    consumer using the Consume method, then the server responds with
    Deliver methods as and when messages arrive for that consumer.
  </doc>
  <doc name = "rule" test = "amq_basic_19">
    The server SHOULD track the number of times a message has been
    delivered to clients and when a message is redelivered a certain
    number of times - e.g. 5 times - without being acknowledged, the
    server SHOULD consider the message to be unprocessable (possibly
    causing client applications to abort), and move the message to a
    dead letter queue.
  </doc>
  <chassis name = "client" implement = "MUST" />

  <field name = "consumer tag" domain = "consumer tag" />

  <field name = "delivery tag" domain = "delivery tag" />

  <field name = "redelivered" domain = "redelivered" />

  <field name = "exchange" domain = "exchange name">
    <doc>
      Specifies the name of the exchange that the message was
      originally published to.
    </doc>
  </field>

  <field name = "routing key" type = "shortstr">
     Message routing key
    <doc>
      Specifies the routing key name specified when the message was
      published.
    </doc>
  </field>
</method>


<!-- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -->

<method name = "get" synchronous = "1" index = "70">
  direct access to a queue
  <doc>
    This method provides a direct access to the messages in a queue
    using a synchronous dialogue that is designed for specific types of
    application where synchronous functionality is more important than
    performance.
  </doc>
  <response name = "get-ok" />
  <response name = "get-empty" />
  <chassis name = "server" implement = "MUST" />

  <field name = "ticket" domain = "access ticket">
    <doc name = "rule">
      The client MUST provide a valid access ticket giving "read"
      access rights to the realm for the queue.
    </doc>
  </field>

  <field name = "queue" domain = "queue name">
    <doc>
      Specifies the name of the queue to consume from.  If the queue name
      is null, refers to the current queue for the channel, which is the
      last declared queue.
    </doc>
    <doc name = "rule">
      If the client did not previously declare a queue, and the queue name
      in this method is empty, the server MUST raise a connection exception
      with reply code 530 (not allowed).
    </doc>
  </field>

  <field name = "no ack" domain = "no ack" />
</method>

<method name = "get-ok" synchronous = "1" content = "1" index = "71">
  provide client with a message
  <doc>
    This method delivers a message to the client following a get
    method.  A message delivered by 'get-ok' must be acknowledged
    unless the no-ack option was set in the get method.
  </doc>
  <chassis name = "client" implement = "MAY" />

  <field name = "delivery tag" domain = "delivery tag" />

  <field name = "redelivered"  domain = "redelivered"  />

  <field name = "exchange" domain = "exchange name">
    <doc>
      Specifies the name of the exchange that the message was originally
      published to.  If empty, the message was published to the default
      exchange.
    </doc>
  </field>

  <field name = "routing key" type = "shortstr">
     Message routing key
    <doc>
      Specifies the routing key name specified when the message was
      published.
    </doc>
  </field>

  <field name = "message count" type = "long" >
    number of messages pending
    <doc>
      This field reports the number of messages pending on the queue,
      excluding the message being delivered.  Note that this figure is
      indicative, not reliable, and can change arbitrarily as messages
      are added to the queue and removed by other clients.
    </doc>
  </field>
</method>


<method name = "get-empty" synchronous = "1" index = "72">
  indicate no messages available
  <doc>
    This method tells the client that the queue has no messages
    available for the client.
  </doc>
  <chassis name = "client" implement = "MAY" />

  <field name = "cluster id" type = "shortstr">
     Cluster id
    <doc>
      For use by cluster applications, should not be used by
      client applications.
    </doc>
  </field>
</method>

<!-- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -->

<method name = "ack" index = "80">
  acknowledge one or more messages
  <doc>
    This method acknowledges one or more messages delivered via the
    Deliver or Get-Ok methods.  The client can ask to confirm a
    single message or a set of messages up to and including a specific
    message.
  </doc>
  <chassis name = "server" implement = "MUST" />
  <field name = "delivery tag" domain = "delivery tag" />

  <field name = "multiple" type = "bit">
    acknowledge multiple messages
    <doc>
      If set to 1, the delivery tag is treated as "up to and including",
      so that the client can acknowledge multiple messages with a single
      method.  If set to zero, the delivery tag refers to a single
      message.  If the multiple field is 1, and the delivery tag is zero,
      tells the server to acknowledge all outstanding mesages.
    </doc>
    <doc name = "rule" test = "amq_basic_20">
      The server MUST validate that a non-zero delivery-tag refers to an
      delivered message, and raise a channel exception if this is not the
      case.
    </doc>
  </field>
</method>

<!-- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -->

<method name = "reject" index = "90">
  reject an incoming message
  <doc>
    This method allows a client to reject a message.  It can be used to
    interrupt and cancel large incoming messages, or return untreatable
    messages to their original queue.
  </doc>
  <doc name = "rule" test = "amq_basic_21">
    The server SHOULD be capable of accepting and process the Reject
    method while sending message content with a Deliver or Get-Ok
    method.  I.e. the server should read and process incoming methods
    while sending output frames.  To cancel a partially-send content,
    the server sends a content body frame of size 1 (i.e. with no data
    except the frame-end octet).
  </doc>
  <doc name = "rule" test = "amq_basic_22">
    The server SHOULD interpret this method as meaning that the client
    is unable to process the message at this time.
  </doc>
  <doc name = "rule">
    A client MUST NOT use this method as a means of selecting messages
    to process.  A rejected message MAY be discarded or dead-lettered,
    not necessarily passed to another client.
  </doc>      
  <chassis name = "server" implement = "MUST" />
    
  <field name = "delivery tag" domain = "delivery tag" />

  <field name = "requeue" type = "bit">
    requeue the message
    <doc>
      If this field is zero, the message will be discarded.  If this bit
      is 1, the server will attempt to requeue the message.
    </doc>
    <doc name = "rule" test = "amq_basic_23">
      The server MUST NOT deliver the message to the same client within
      the context of the current channel.  The recommended strategy is
      to attempt to deliver the message to an alternative consumer, and
      if that is not possible, to move the message to a dead-letter
      queue.  The server MAY use more sophisticated tracking to hold
      the message on the queue and redeliver it to the same client at
      a later stage.
    </doc>
  </field>
</method>

<method name = "recover" index = "100">
  redeliver unacknowledged messages. This method is only allowed on non-transacted channels.
  <doc>
    This method asks the broker to redeliver all unacknowledged messages on a
    specifieid channel. Zero or more messages may be redelivered.
  </doc>
  <chassis name = "server" implement = "MUST" />

  <field name = "requeue" type = "bit">
    requeue the message
    <doc>
      If this field is zero, the message will be redelivered to the original recipient.  If this bit
      is 1, the server will attempt to requeue the message, potentially then delivering it to an
      alternative subscriber.
    </doc>
  </field>

    <doc name="rule">
      The server MUST set the redelivered flag on all messages that are resent.
    </doc>
    <doc name="rule">
    The server MUST raise a channel exception if this is called on a transacted channel.
    </doc>
</method>


</class>


  <class name="file" handler="channel" index="70">
    <!--
======================================================
==      FILE TRANSFER
======================================================
-->
  work with file content
<doc>
  The file class provides methods that support reliable file transfer.
  File messages have a specific set of properties that are required for
  interoperability with file transfer applications. File messages and
  acknowledgements are subject to channel transactions.  Note that the
  file class does not provide message browsing methods; these are not
  compatible with the staging model.  Applications that need browsable
  file transfer should use Basic content and the Basic class.
</doc>

<doc name = "grammar">
    file                = C:QOS S:QOS-OK
                        / C:CONSUME S:CONSUME-OK
                        / C:CANCEL S:CANCEL-OK
                        / C:OPEN S:OPEN-OK C:STAGE content
                        / S:OPEN C:OPEN-OK S:STAGE content
                        / C:PUBLISH
                        / S:DELIVER
                        / S:RETURN
                        / C:ACK
                        / C:REJECT
</doc>

<chassis name = "server" implement = "MAY" />
<chassis name = "client" implement = "MAY" />

<doc name = "rule">
  The server MUST make a best-effort to hold file messages on a
  reliable storage mechanism.
</doc>
<doc name = "rule">
  The server MUST NOT discard a file message in case of a queue
  overflow. The server MUST use the Channel.Flow method to slow or stop
  a file message publisher when necessary.
</doc>
<doc name = "rule">
  The server MUST implement at least 2 priority levels for file
  messages, where priorities 0-4 and 5-9 are treated as two distinct
  levels. The server MAY implement up to 10 priority levels.
</doc>
<doc name = "rule">
  The server MUST support both automatic and explicit acknowledgements
  on file content.
</doc>

<!--  These are the properties for a File content  -->

<field name = "content type" type = "shortstr">
    MIME content type
</field>
<field name = "content encoding" type = "shortstr">
    MIME content encoding
</field>
<field name = "headers" type = "table">
    Message header field table
</field>
<field name = "priority" type = "octet">
    The message priority, 0 to 9
</field>
<field name = "reply to" type = "shortstr">
    The destination to reply to
</field>
<field name = "message id" type = "shortstr">
    The application message identifier
</field>
<field name = "filename" type = "shortstr">
    The message filename
</field>
<field name = "timestamp" type = "timestamp">
    The message timestamp
</field>
<field name = "cluster id" type = "shortstr">
    Intra-cluster routing identifier
</field>


<!-- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -->

<method name = "qos" synchronous = "1" index = "10">
  specify quality of service
  <doc>
    This method requests a specific quality of service.  The QoS can
    be specified for the current channel or for all channels on the
    connection.  The particular properties and semantics of a qos method
    always depend on the content class semantics.  Though the qos method
    could in principle apply to both peers, it is currently meaningful
    only for the server.
  </doc>
  <chassis name = "server" implement = "MUST" />
  <response name = "qos-ok" />

  <field name = "prefetch size" type = "long">
    prefetch window in octets
    <doc>
      The client can request that messages be sent in advance so that
      when the client finishes processing a message, the following
      message is already held locally, rather than needing to be sent
      down the channel.  Prefetching gives a performance improvement.
      This field specifies the prefetch window size in octets. May be
      set to zero, meaning "no specific limit".  Note that other
      prefetch limits may still apply. The prefetch-size is ignored
      if the no-ack option is set.
    </doc>
  </field>

  <field name = "prefetch count" type = "short">
    prefetch window in messages
    <doc>
      Specifies a prefetch window in terms of whole messages.  This
      is compatible with some file API implementations.  This field
      may be used in combination with the prefetch-size field; a
      message will only be sent in advance if both prefetch windows
      (and those at the channel and connection level) allow it.
      The prefetch-count is ignored if the no-ack option is set.
    </doc>
    <doc name = "rule">
      The server MAY send less data in advance than allowed by the
      client's specified prefetch windows but it MUST NOT send more.
    </doc>
  </field>

  <field name = "global" type = "bit">
    apply to entire connection
    <doc>
      By default the QoS settings apply to the current channel only.  If
      this field is set, they are applied to the entire connection.
    </doc>
  </field>
</method>

<method name = "qos-ok" synchronous = "1" index = "11">
  confirm the requested qos
  <doc>
    This method tells the client that the requested QoS levels could
    be handled by the server.  The requested QoS applies to all active
    consumers until a new QoS is defined.
  </doc>
  <chassis name = "client" implement = "MUST" />
</method>

<!-- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -->

<method name = "consume" synchronous = "1" index = "20">
  start a queue consumer
  <doc>
    This method asks the server to start a "consumer", which is a
    transient request for messages from a specific queue. Consumers
    last as long as the channel they were created on, or until the
    client cancels them.
  </doc>
  <doc name = "rule">
    The server SHOULD support at least 16 consumers per queue, unless
    the queue was declared as private, and ideally, impose no limit
    except as defined by available resources.
  </doc>
  <chassis name = "server" implement = "MUST" />
  <response name = "consume-ok" />

  <field name = "ticket" domain = "access ticket">
    <doc name = "rule">
      The client MUST provide a valid access ticket giving "read" access
      rights to the realm for the queue.
    </doc>
  </field>

  <field name = "queue" domain = "queue name">
    <doc>
      Specifies the name of the queue to consume from.  If the queue name
      is null, refers to the current queue for the channel, which is the
      last declared queue.
    </doc>
    <doc name = "rule">
      If the client did not previously declare a queue, and the queue name
      in this method is empty, the server MUST raise a connection exception
      with reply code 530 (not allowed).
    </doc>
  </field>

  <field name = "consumer tag" domain = "consumer tag">
    <doc>
      Specifies the identifier for the consumer. The consumer tag is
      local to a connection, so two clients can use the same consumer
      tags. If this field is empty the server will generate a unique
      tag.
    </doc>
    <doc name = "rule" test = "todo">
      The tag MUST NOT refer to an existing consumer. If the client
      attempts to create two consumers with the same non-empty tag
      the server MUST raise a connection exception with reply code
      530 (not allowed).
    </doc>
  </field>

  <field name = "no local" domain = "no local" />

  <field name = "no ack" domain = "no ack" />

  <field name = "exclusive" type = "bit">
    request exclusive access
    <doc>
      Request exclusive consumer access, meaning only this consumer can
      access the queue.
    </doc>
    <doc name = "rule" test = "amq_file_00">
      If the server cannot grant exclusive access to the queue when asked,
      - because there are other consumers active - it MUST raise a channel
      exception with return code 405 (resource locked).
    </doc>
  </field>

  <field name = "nowait" type = "bit">
    do not send a reply method
    <doc>
    If set, the server will not respond to the method. The client should
    not wait for a reply method.  If the server could not complete the
    method it will raise a channel or connection exception.
    </doc>
  </field>
</method>

<method name = "consume-ok" synchronous = "1" index = "21">
  confirm a new consumer
  <doc>
    This method provides the client with a consumer tag which it MUST
    use in methods that work with the consumer.
  </doc>
  <chassis name = "client" implement = "MUST" />

  <field name = "consumer tag" domain = "consumer tag">
    <doc>
      Holds the consumer tag specified by the client or provided by
      the server.
    </doc>
  </field>
</method>


<!-- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -->

<method name = "cancel" synchronous = "1" index = "30">
  end a queue consumer
  <doc>
    This method cancels a consumer. This does not affect already
    delivered messages, but it does mean the server will not send any
    more messages for that consumer.
  </doc>
  <chassis name = "server" implement = "MUST" />
  <response name = "cancel-ok" />

  <field name = "consumer tag" domain = "consumer tag" />

  <field name = "nowait" type = "bit">
    do not send a reply method
    <doc>
    If set, the server will not respond to the method. The client should
    not wait for a reply method.  If the server could not complete the
    method it will raise a channel or connection exception.
    </doc>
  </field>
</method>

<method name = "cancel-ok" synchronous = "1" index = "31">
  confirm a cancelled consumer
  <doc>
    This method confirms that the cancellation was completed.
  </doc>
  <chassis name = "client" implement = "MUST" />

  <field name = "consumer tag" domain = "consumer tag" />
</method>


<!-- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -->

<method name = "open" synchronous = "1" index = "40">
  request to start staging
  <doc>
    This method requests permission to start staging a message.  Staging
    means sending the message into a temporary area at the recipient end
    and then delivering the message by referring to this temporary area.
    Staging is how the protocol handles partial file transfers - if a
    message is partially staged and the connection breaks, the next time
    the sender starts to stage it, it can restart from where it left off.
  </doc>
  <response name = "open-ok" />
  <chassis name = "server" implement = "MUST" />
  <chassis name = "client" implement = "MUST" />
  
  <field name = "identifier" type = "shortstr">
    staging identifier
    <doc>
      This is the staging identifier. This is an arbitrary string chosen
      by the sender.  For staging to work correctly the sender must use
      the same staging identifier when staging the same message a second
      time after recovery from a failure.  A good choice for the staging
      identifier would be the SHA1 hash of the message properties data
      (including the original filename, revised time, etc.).
    </doc>
  </field>

  <field name = "content size" type = "longlong">
    message content size
    <doc>
      The size of the content in octets.  The recipient may use this
      information to allocate or check available space in advance, to
      avoid "disk full" errors during staging of very large messages.
    </doc>
    <doc name = "rule">
      The sender MUST accurately fill the content-size field.
      Zero-length content is permitted.
    </doc>
  </field>
</method>

<method name = "open-ok" synchronous = "1" index = "41">
  confirm staging ready
  <doc>
    This method confirms that the recipient is ready to accept staged
    data.  If the message was already partially-staged at a previous
    time the recipient will report the number of octets already staged.
  </doc>
  <response name = "stage" />
  <chassis name = "server" implement = "MUST" />
  <chassis name = "client" implement = "MUST" />
  
  <field name = "staged size" type = "longlong">
    already staged amount
    <doc>
      The amount of previously-staged content in octets.  For a new
      message this will be zero.
    </doc>
    <doc name = "rule">
      The sender MUST start sending data from this octet offset in the
      message, counting from zero.
    </doc>
    <doc name = "rule">
      The recipient MAY decide how long to hold partially-staged content
      and MAY implement staging by always discarding partially-staged
      content.  However if it uses the file content type it MUST support
      the staging methods.
    </doc>
  </field>
</method>

<!-- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -->

<method name = "stage" content = "1" index = "50">
  stage message content
  <doc>
    This method stages the message, sending the message content to the
    recipient from the octet offset specified in the Open-Ok method.
  </doc>
  <chassis name = "server" implement = "MUST" />
  <chassis name = "client" implement = "MUST" />
</method>


<!-- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -->

<method name = "publish" index = "60">
  publish a message
  <doc>
    This method publishes a staged file message to a specific exchange.
    The file message will be routed to queues as defined by the exchange
    configuration and distributed to any active consumers when the
    transaction, if any, is committed.
  </doc>
  <chassis name = "server" implement = "MUST" />

  <field name = "ticket" domain = "access ticket">
    <doc name = "rule">
      The client MUST provide a valid access ticket giving "write"
      access rights to the access realm for the exchange.
    </doc>
  </field>

  <field name = "exchange" domain = "exchange name">
    <doc>
      Specifies the name of the exchange to publish to.  The exchange
      name can be empty, meaning the default exchange.  If the exchange
      name is specified, and that exchange does not exist, the server
      will raise a channel exception.
    </doc>
    <doc name = "rule">
      The server MUST accept a blank exchange name to mean the default
      exchange.
    </doc>
    <doc name = "rule">
      If the exchange was declared as an internal exchange, the server
      MUST respond with a reply code 403 (access refused) and raise a
      channel exception.
    </doc>
    <doc name = "rule">
      The exchange MAY refuse file content in which case it MUST respond
      with a reply code 540 (not implemented) and raise a channel
      exception.
    </doc>
  </field>

  <field name = "routing key" type = "shortstr">
     Message routing key
    <doc>
      Specifies the routing key for the message.  The routing key is
      used for routing messages depending on the exchange configuration.
    </doc>
  </field>

  <field name = "mandatory" type = "bit">
    indicate mandatory routing
    <doc>
      This flag tells the server how to react if the message cannot be
      routed to a queue.  If this flag is set, the server will return an
      unroutable message with a Return method.  If this flag is zero, the
      server silently drops the message.
    </doc>
    <doc name = "rule" test = "amq_file_00">
      The server SHOULD implement the mandatory flag.
    </doc>
  </field>

  <field name = "immediate" type = "bit">
    request immediate delivery
    <doc>
      This flag tells the server how to react if the message cannot be
      routed to a queue consumer immediately.  If this flag is set, the
      server will return an undeliverable message with a Return method.
      If this flag is zero, the server will queue the message, but with
      no guarantee that it will ever be consumed.
    </doc>
    <doc name = "rule" test = "amq_file_00">
      The server SHOULD implement the immediate flag.
    </doc>
  </field>

  <field name = "identifier" type = "shortstr">
    staging identifier
    <doc>
      This is the staging identifier of the message to publish.  The
      message must have been staged.  Note that a client can send the
      Publish method asynchronously without waiting for staging to
      finish.
    </doc>
  </field>
</method>

<method name = "return" content = "1" index = "70">
  return a failed message
  <doc>
    This method returns an undeliverable message that was published
    with the "immediate" flag set, or an unroutable message published
    with the "mandatory" flag set. The reply code and text provide
    information about the reason that the message was undeliverable.
  </doc>
  <chassis name = "client" implement = "MUST" />

  <field name = "reply code" domain = "reply code" />
  <field name = "reply text" domain = "reply text" />

  <field name = "exchange" domain = "exchange name">
    <doc>
      Specifies the name of the exchange that the message was
      originally published to.
    </doc>
  </field>

  <field name = "routing key" type = "shortstr">
     Message routing key
    <doc>
      Specifies the routing key name specified when the message was
      published.
    </doc>
  </field>
</method>


<!-- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -->

<method name = "deliver" index = "80">
  notify the client of a consumer message
  <doc>
    This method delivers a staged file message to the client, via a
    consumer. In the asynchronous message delivery model, the client
    starts a consumer using the Consume method, then the server
    responds with Deliver methods as and when messages arrive for
    that consumer.
  </doc>
  <doc name = "rule">
    The server SHOULD track the number of times a message has been
    delivered to clients and when a message is redelivered a certain
    number of times - e.g. 5 times - without being acknowledged, the
    server SHOULD consider the message to be unprocessable (possibly
    causing client applications to abort), and move the message to a
    dead letter queue.
  </doc>
  <chassis name = "client" implement = "MUST" />

  <field name = "consumer tag" domain = "consumer tag" />

  <field name = "delivery tag" domain = "delivery tag" />

  <field name = "redelivered" domain = "redelivered" />

  <field name = "exchange" domain = "exchange name">
    <doc>
      Specifies the name of the exchange that the message was originally
      published to.
    </doc>
  </field>

  <field name = "routing key" type = "shortstr">
     Message routing key
    <doc>
      Specifies the routing key name specified when the message was
      published.
    </doc>
  </field>

  <field name = "identifier" type = "shortstr">
    staging identifier
    <doc>
      This is the staging identifier of the message to deliver.  The
      message must have been staged.  Note that a server can send the
      Deliver method asynchronously without waiting for staging to
      finish.
    </doc>
  </field>
</method>


<!-- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -->

<method name = "ack" index = "90">
  acknowledge one or more messages
  <doc>
    This method acknowledges one or more messages delivered via the
    Deliver method.  The client can ask to confirm a single message or
    a set of messages up to and including a specific message.
  </doc>
  <chassis name = "server" implement = "MUST" />
  <field name = "delivery tag" domain = "delivery tag" />
      
  <field name = "multiple" type = "bit">
    acknowledge multiple messages
    <doc>
      If set to 1, the delivery tag is treated as "up to and including",
      so that the client can acknowledge multiple messages with a single
      method.  If set to zero, the delivery tag refers to a single
      message.  If the multiple field is 1, and the delivery tag is zero,
      tells the server to acknowledge all outstanding mesages.
    </doc>
    <doc name = "rule">
      The server MUST validate that a non-zero delivery-tag refers to an
      delivered message, and raise a channel exception if this is not the
      case.
    </doc>
  </field>
</method>


<!-- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -->

<method name = "reject" index = "100">
  reject an incoming message
  <doc>
    This method allows a client to reject a message.  It can be used to
    return untreatable messages to their original queue.  Note that file
    content is staged before delivery, so the client will not use this
    method to interrupt delivery of a large message.
  </doc>
  <doc name = "rule">
    The server SHOULD interpret this method as meaning that the client
    is unable to process the message at this time.
  </doc>
  <doc name = "rule">
    A client MUST NOT use this method as a means of selecting messages
    to process.  A rejected message MAY be discarded or dead-lettered,
    not necessarily passed to another client.
  </doc>
  <chassis name = "server" implement = "MUST" />
    
  <field name = "delivery tag" domain = "delivery tag" />

  <field name = "requeue" type = "bit">
    requeue the message
    <doc>
      If this field is zero, the message will be discarded.  If this bit
      is 1, the server will attempt to requeue the message.
    </doc>
    <doc name = "rule">
      The server MUST NOT deliver the message to the same client within
      the context of the current channel.  The recommended strategy is
      to attempt to deliver the message to an alternative consumer, and
      if that is not possible, to move the message to a dead-letter
      queue.  The server MAY use more sophisticated tracking to hold
      the message on the queue and redeliver it to the same client at
      a later stage.
    </doc>
  </field>
</method>

</class>

  <class name="stream" handler="channel" index="80">
    <!--
======================================================
==       STREAMING
======================================================
-->
  work with streaming content

<doc>
  The stream class provides methods that support multimedia streaming.
  The stream class uses the following semantics: one message is one
  packet of data; delivery is unacknowleged and unreliable; the consumer
  can specify quality of service parameters that the server can try to
  adhere to; lower-priority messages may be discarded in favour of high
  priority messages.
</doc>

<doc name = "grammar">
    stream              = C:QOS S:QOS-OK
                        / C:CONSUME S:CONSUME-OK
                        / C:CANCEL S:CANCEL-OK
                        / C:PUBLISH content
                        / S:RETURN
                        / S:DELIVER content
</doc>

<chassis name = "server" implement = "MAY" />
<chassis name = "client" implement = "MAY" />

<doc name = "rule">
  The server SHOULD discard stream messages on a priority basis if
  the queue size exceeds some configured limit.
</doc>
<doc name = "rule">
  The server MUST implement at least 2 priority levels for stream
  messages, where priorities 0-4 and 5-9 are treated as two distinct
  levels. The server MAY implement up to 10 priority levels.
</doc>
<doc name = "rule">
  The server MUST implement automatic acknowledgements on stream
  content.  That is, as soon as a message is delivered to a client
  via a Deliver method, the server must remove it from the queue.
</doc>


<!--  These are the properties for a Stream content  -->

<field name = "content type" type = "shortstr">
    MIME content type
</field>
<field name = "content encoding" type = "shortstr">
    MIME content encoding
</field>
<field name = "headers" type = "table">
    Message header field table
</field>
<field name = "priority" type = "octet">
    The message priority, 0 to 9
</field>
<field name = "timestamp" type = "timestamp">
    The message timestamp
</field>


<!-- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -->

<method name = "qos" synchronous = "1" index = "10">
  specify quality of service
  <doc>
    This method requests a specific quality of service.  The QoS can
    be specified for the current channel or for all channels on the
    connection.  The particular properties and semantics of a qos method
    always depend on the content class semantics.  Though the qos method
    could in principle apply to both peers, it is currently meaningful
    only for the server.
  </doc>
  <chassis name = "server" implement = "MUST" />
  <response name = "qos-ok" />

  <field name = "prefetch size" type = "long">
    prefetch window in octets
    <doc>
      The client can request that messages be sent in advance so that
      when the client finishes processing a message, the following
      message is already held locally, rather than needing to be sent
      down the channel.  Prefetching gives a performance improvement.
      This field specifies the prefetch window size in octets. May be
      set to zero, meaning "no specific limit".  Note that other
      prefetch limits may still apply.
    </doc>
  </field>

  <field name = "prefetch count" type = "short">
    prefetch window in messages
    <doc>
      Specifies a prefetch window in terms of whole messages.  This
      field may be used in combination with the prefetch-size field;
      a message will only be sent in advance if both prefetch windows
      (and those at the channel and connection level) allow it.
    </doc>
  </field>

  <field name = "consume rate" type = "long">
    transfer rate in octets/second
    <doc>
      Specifies a desired transfer rate in octets per second. This is
      usually determined by the application that uses the streaming
      data.  A value of zero means "no limit", i.e. as rapidly as
      possible.
    </doc>
    <doc name = "rule">
      The server MAY ignore the prefetch values and consume rates,
      depending on the type of stream and the ability of the server
      to queue and/or reply it.  The server MAY drop low-priority
      messages in favour of high-priority messages.
    </doc>
  </field>

  <field name = "global" type = "bit">
    apply to entire connection
    <doc>
      By default the QoS settings apply to the current channel only.  If
      this field is set, they are applied to the entire connection.
    </doc>
  </field>
</method>

<method name = "qos-ok" synchronous = "1" index = "11">
  confirm the requested qos
  <doc>
    This method tells the client that the requested QoS levels could
    be handled by the server.  The requested QoS applies to all active
    consumers until a new QoS is defined.
  </doc>
  <chassis name = "client" implement = "MUST" />
</method>

<!-- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -->

<method name = "consume" synchronous = "1" index = "20">
  start a queue consumer
  <doc>
    This method asks the server to start a "consumer", which is a
    transient request for messages from a specific queue. Consumers
    last as long as the channel they were created on, or until the
    client cancels them.
  </doc>
  <doc name = "rule">
    The server SHOULD support at least 16 consumers per queue, unless
    the queue was declared as private, and ideally, impose no limit
    except as defined by available resources.
  </doc>
  <doc name = "rule">
    Streaming applications SHOULD use different channels to select
    different streaming resolutions. AMQP makes no provision for
    filtering and/or transforming streams except on the basis of
    priority-based selective delivery of individual messages.
  </doc>
  <chassis name = "server" implement = "MUST" />
  <response name = "consume-ok" />

  <field name = "ticket" domain = "access ticket">
    <doc name = "rule">
      The client MUST provide a valid access ticket giving "read" access
      rights to the realm for the queue.
    </doc>
  </field>

  <field name = "queue" domain = "queue name">
    <doc>
      Specifies the name of the queue to consume from.  If the queue name
      is null, refers to the current queue for the channel, which is the
      last declared queue.
    </doc>
    <doc name = "rule">
      If the client did not previously declare a queue, and the queue name
      in this method is empty, the server MUST raise a connection exception
      with reply code 530 (not allowed).
    </doc>
  </field>

  <field name = "consumer tag" domain = "consumer tag">
    <doc>
      Specifies the identifier for the consumer. The consumer tag is
      local to a connection, so two clients can use the same consumer
      tags. If this field is empty the server will generate a unique
      tag.
    </doc>
    <doc name = "rule" test = "todo">
      The tag MUST NOT refer to an existing consumer. If the client
      attempts to create two consumers with the same non-empty tag
      the server MUST raise a connection exception with reply code
      530 (not allowed).
    </doc>
  </field>

  <field name = "no local" domain = "no local" />

  <field name = "exclusive" type = "bit">
    request exclusive access
    <doc>
      Request exclusive consumer access, meaning only this consumer can
      access the queue.
    </doc>
    <doc name = "rule" test = "amq_file_00">
      If the server cannot grant exclusive access to the queue when asked,
      - because there are other consumers active - it MUST raise a channel
      exception with return code 405 (resource locked).
    </doc>
  </field>

  <field name = "nowait" type = "bit">
    do not send a reply method
    <doc>
    If set, the server will not respond to the method. The client should
    not wait for a reply method.  If the server could not complete the
    method it will raise a channel or connection exception.
    </doc>
  </field>
</method>


<method name = "consume-ok" synchronous = "1" index = "21">
  confirm a new consumer
  <doc>
    This method provides the client with a consumer tag which it may
    use in methods that work with the consumer.
  </doc>
  <chassis name = "client" implement = "MUST" />

  <field name = "consumer tag" domain = "consumer tag">
    <doc>
      Holds the consumer tag specified by the client or provided by
      the server.
    </doc>
  </field>
</method>

<!-- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -->

<method name = "cancel" synchronous = "1" index = "30">
  end a queue consumer
  <doc>
    This method cancels a consumer.  Since message delivery is
    asynchronous the client may continue to receive messages for
    a short while after canceling a consumer.  It may process or
    discard these as appropriate.
  </doc>
  <chassis name = "server" implement = "MUST" />
  <response name = "cancel-ok" />

  <field name = "consumer tag" domain = "consumer tag" />

  <field name = "nowait" type = "bit">
    do not send a reply method
    <doc>
    If set, the server will not respond to the method. The client should
    not wait for a reply method.  If the server could not complete the
    method it will raise a channel or connection exception.
    </doc>
  </field>
</method>

<method name = "cancel-ok" synchronous = "1" index = "31">
  confirm a cancelled consumer
  <doc>
    This method confirms that the cancellation was completed.
  </doc>
  <chassis name = "client" implement = "MUST" />

  <field name = "consumer tag" domain = "consumer tag" />
</method>


<!-- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -->

<method name = "publish" content = "1" index = "40">
  publish a message
  <doc>
    This method publishes a message to a specific exchange. The message
    will be routed to queues as defined by the exchange configuration
    and distributed to any active consumers as appropriate.
  </doc>
  <chassis name = "server" implement = "MUST" />

  <field name = "ticket" domain = "access ticket">
    <doc name = "rule">
      The client MUST provide a valid access ticket giving "write"
      access rights to the access realm for the exchange.
    </doc>
  </field>

  <field name = "exchange" domain = "exchange name">
    <doc>
      Specifies the name of the exchange to publish to.  The exchange
      name can be empty, meaning the default exchange.  If the exchange
      name is specified, and that exchange does not exist, the server
      will raise a channel exception.
    </doc>
    <doc name = "rule">
      The server MUST accept a blank exchange name to mean the default
      exchange.
    </doc>
    <doc name = "rule">
      If the exchange was declared as an internal exchange, the server
      MUST respond with a reply code 403 (access refused) and raise a
      channel exception.
    </doc>
    <doc name = "rule">
      The exchange MAY refuse stream content in which case it MUST
      respond with a reply code 540 (not implemented) and raise a
      channel exception.
    </doc>
  </field>

  <field name = "routing key" type = "shortstr">
     Message routing key
    <doc>
      Specifies the routing key for the message.  The routing key is
      used for routing messages depending on the exchange configuration.
    </doc>
  </field>

  <field name = "mandatory" type = "bit">
    indicate mandatory routing
    <doc>
      This flag tells the server how to react if the message cannot be
      routed to a queue.  If this flag is set, the server will return an
      unroutable message with a Return method.  If this flag is zero, the
      server silently drops the message.
    </doc>
    <doc name = "rule" test = "amq_stream_00">
      The server SHOULD implement the mandatory flag.
    </doc>
  </field>

  <field name = "immediate" type = "bit">
    request immediate delivery
    <doc>
      This flag tells the server how to react if the message cannot be
      routed to a queue consumer immediately.  If this flag is set, the
      server will return an undeliverable message with a Return method.
      If this flag is zero, the server will queue the message, but with
      no guarantee that it will ever be consumed.
    </doc>
    <doc name = "rule" test = "amq_stream_00">
      The server SHOULD implement the immediate flag.
    </doc>
  </field>
</method>

<method name = "return" content = "1" index = "50">
  return a failed message
  <doc>
    This method returns an undeliverable message that was published
    with the "immediate" flag set, or an unroutable message published
    with the "mandatory" flag set. The reply code and text provide
    information about the reason that the message was undeliverable.
  </doc>
  <chassis name = "client" implement = "MUST" />

  <field name = "reply code" domain = "reply code" />
  <field name = "reply text" domain = "reply text" />

  <field name = "exchange" domain = "exchange name">
    <doc>
      Specifies the name of the exchange that the message was
      originally published to.
    </doc>
  </field>

  <field name = "routing key" type = "shortstr">
     Message routing key
    <doc>
      Specifies the routing key name specified when the message was
      published.
    </doc>     
  </field>
</method>


<!-- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -->

<method name = "deliver" content = "1" index = "60">
  notify the client of a consumer message
  <doc>
    This method delivers a message to the client, via a consumer.  In
    the asynchronous message delivery model, the client starts a
    consumer using the Consume method, then the server responds with
    Deliver methods as and when messages arrive for that consumer.
  </doc>
  <chassis name = "client" implement = "MUST" />

  <field name = "consumer tag" domain = "consumer tag" />

  <field name = "delivery tag" domain = "delivery tag" />

  <field name = "exchange" domain = "exchange name">
    <doc>
      Specifies the name of the exchange that the message was originally
      published to.
    </doc>
  </field>

  <field name = "queue" domain = "queue name">
    <doc>
      Specifies the name of the queue that the message came from. Note
      that a single channel can start many consumers on different
      queues.
    </doc>
    <assert check = "notnull" />
  </field>
</method>
  </class>

  <class name="tx" handler="channel" index="90">
    <!--
======================================================
==       TRANSACTIONS
======================================================
-->
  work with standard transactions

<doc>
  Standard transactions provide so-called "1.5 phase commit".  We can
  ensure that work is never lost, but there is a chance of confirmations
  being lost, so that messages may be resent.  Applications that use
  standard transactions must be able to detect and ignore duplicate
  messages.
</doc>
    <rule implement="SHOULD">
  An client using standard transactions SHOULD be able to track all
  messages received within a reasonable period, and thus detect and
  reject duplicates of the same message. It SHOULD NOT pass these to
  the application layer.
</rule>
    <doc name="grammar">
    tx                  = C:SELECT S:SELECT-OK
                        / C:COMMIT S:COMMIT-OK
                        / C:ROLLBACK S:ROLLBACK-OK
</doc>
    <chassis name="server" implement="SHOULD"/>
    <chassis name="client" implement="MAY"/>
    <!-- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -->
    <method name="select" synchronous="1" index="10">
select standard transaction mode
  <doc>
    This method sets the channel to use standard transactions.  The
    client must use this method at least once on a channel before
    using the Commit or Rollback methods.
  </doc>
      <chassis name="server" implement="MUST"/>
      <response name="select-ok"/>
    </method>
    <method name="select-ok" synchronous="1" index="11">
confirm transaction mode
  <doc>
    This method confirms to the client that the channel was successfully
    set to use standard transactions.
  </doc>
      <chassis name="client" implement="MUST"/>
    </method>
    <!-- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -->
    <method name="commit" synchronous="1" index="20">
commit the current transaction
  <doc>
    This method commits all messages published and acknowledged in
    the current transaction.  A new transaction starts immediately
    after a commit.
  </doc>
      <chassis name="server" implement="MUST"/>
      <response name="commit-ok"/>
    </method>
    <method name="commit-ok" synchronous="1" index="21">
confirm a successful commit
  <doc>
    This method confirms to the client that the commit succeeded.
    Note that if a commit fails, the server raises a channel exception.
  </doc>
      <chassis name="client" implement="MUST"/>
    </method>
    <!-- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -->
    <method name="rollback" synchronous="1" index="30">
abandon the current transaction
  <doc>
    This method abandons all messages published and acknowledged in
    the current transaction.  A new transaction starts immediately
    after a rollback.
  </doc>
      <chassis name="server" implement="MUST"/>
      <response name="rollback-ok"/>
    </method>
    <method name="rollback-ok" synchronous="1" index="31">
confirm a successful rollback
  <doc>
    This method confirms to the client that the rollback succeeded.
    Note that if an rollback fails, the server raises a channel exception.
  </doc>
      <chassis name="client" implement="MUST"/>
    </method>
  </class>
  <class name="dtx" handler="channel" index="100">
    <!--
======================================================
==       DISTRIBUTED TRANSACTIONS
======================================================
-->
  work with distributed transactions

<doc>
  Distributed transactions provide so-called "2-phase commit".    The
  AMQP distributed transaction model supports the X-Open XA
  architecture and other distributed transaction implementations.
  The Dtx class assumes that the server has a private communications
  channel (not AMQP) to a distributed transaction coordinator.
</doc>
    <doc name="grammar">
    dtx                 = C:SELECT S:SELECT-OK
                          C:START S:START-OK
</doc>
    <chassis name="server" implement="MAY"/>
    <chassis name="client" implement="MAY"/>
    <!-- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -->
    <method name="select" synchronous="1" index="10">
select standard transaction mode
  <doc>
    This method sets the channel to use distributed transactions.  The
    client must use this method at least once on a channel before
    using the Start method.
  </doc>
      <chassis name="server" implement="MUST"/>
      <response name="select-ok"/>
    </method>
    <method name="select-ok" synchronous="1" index="11">
confirm transaction mode
  <doc>
    This method confirms to the client that the channel was successfully
    set to use distributed transactions.
  </doc>
      <chassis name="client" implement="MUST"/>
    </method>
    <!-- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -->
    <method name="start" synchronous="1" index="20">
  start a new distributed transaction
  <doc>
    This method starts a new distributed transaction.  This must be
    the first method on a new channel that uses the distributed
    transaction mode, before any methods that publish or consume
    messages.
  </doc>
      <chassis name="server" implement="MAY"/>
      <response name="start-ok"/>
      <field name="dtx identifier" type="shortstr">
    transaction identifier
    <doc>
      The distributed transaction key. This identifies the transaction
      so that the AMQP server can coordinate with the distributed
      transaction coordinator.
    </doc>
        <assert check="notnull"/>
      </field>
    </method>
    <method name="start-ok" synchronous="1" index="21">
  confirm the start of a new distributed transaction
  <doc>
    This method confirms to the client that the transaction started.
    Note that if a start fails, the server raises a channel exception.
  </doc>
      <chassis name="client" implement="MUST"/>
    </method>
  </class>
  <class name="tunnel" handler="tunnel" index="110">
    <!--
======================================================
==       TUNNEL
======================================================
-->
  methods for protocol tunneling.

<doc>
  The tunnel methods are used to send blocks of binary data - which
  can be serialised AMQP methods or other protocol frames - between
  AMQP peers.
</doc>
    <doc name="grammar">
    tunnel              = C:REQUEST
                        / S:REQUEST
</doc>
    <chassis name="server" implement="MAY"/>
    <chassis name="client" implement="MAY"/>
    <field name="headers" type="table">
    Message header field table
</field>
    <field name="proxy name" type="shortstr">
    The identity of the tunnelling proxy
</field>
    <field name="data name" type="shortstr">
    The name or type of the message being tunnelled
</field>
    <field name="durable" type="octet">
    The message durability indicator
</field>
    <field name="broadcast" type="octet">
    The message broadcast mode
</field>
    <!-- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -->
    <method name="request" content="1" index="10">
  sends a tunnelled method
  <doc>
    This method tunnels a block of binary data, which can be an
    encoded AMQP method or other data.  The binary data is sent
    as the content for the Tunnel.Request method.
  </doc>
      <chassis name="server" implement="MUST"/>
      <field name="meta data" type="table">
    meta data for the tunnelled block
    <doc>
    This field table holds arbitrary meta-data that the sender needs
    to pass to the recipient.
    </doc>
      </field>
    </method>
  </class>
  <class name="test" handler="channel" index="120">
    <!--
======================================================
==       TEST - CHECK FUNCTIONAL CAPABILITIES OF AN IMPLEMENTATION
======================================================
-->
  test functional primitives of the implementation

<doc>
  The test class provides methods for a peer to test the basic
  operational correctness of another peer. The test methods are
  intended to ensure that all peers respect at least the basic
  elements of the protocol, such as frame and content organisation
  and field types. We assume that a specially-designed peer, a
  "monitor client" would perform such tests.
</doc>
    <doc name="grammar">
    test                = C:INTEGER S:INTEGER-OK
                        / S:INTEGER C:INTEGER-OK
                        / C:STRING S:STRING-OK
                        / S:STRING C:STRING-OK
                        / C:TABLE S:TABLE-OK
                        / S:TABLE C:TABLE-OK
                        / C:CONTENT S:CONTENT-OK
                        / S:CONTENT C:CONTENT-OK
</doc>
    <chassis name="server" implement="MUST"/>
    <chassis name="client" implement="SHOULD"/>
    <!-- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -->
    <method name="integer" synchronous="1" index="10">
  test integer handling
  <doc>
    This method tests the peer's capability to correctly marshal integer
    data.
  </doc>
      <chassis name="client" implement="MUST"/>
      <chassis name="server" implement="MUST"/>
      <response name="integer-ok"/>
      <field name="integer 1" type="octet">
    octet test value
    <doc>
      An octet integer test value.
    </doc>
      </field>
      <field name="integer 2" type="short">
    short test value
    <doc>
      A short integer test value.
    </doc>
      </field>
      <field name="integer 3" type="long">
    long test value
    <doc>
      A long integer test value.
    </doc>
      </field>
      <field name="integer 4" type="longlong">
    long-long test value
    <doc>
      A long long integer test value.
    </doc>
      </field>
      <field name="operation" type="octet">
    operation to test
    <doc>
      The client must execute this operation on the provided integer
      test fields and return the result.
    </doc>
        <assert check="enum">
          <value name="add">return sum of test values</value>
          <value name="min">return lowest of test values</value>
          <value name="max">return highest of test values</value>
        </assert>
      </field>
    </method>
    <method name="integer-ok" synchronous="1" index="11">
  report integer test result
  <doc>
    This method reports the result of an Integer method.
  </doc>
      <chassis name="client" implement="MUST"/>
      <chassis name="server" implement="MUST"/>
      <field name="result" type="longlong">
    result value
    <doc>
      The result of the tested operation.
    </doc>
      </field>
    </method>
    <!-- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -->
    <method name="string" synchronous="1" index="20">
  test string handling
  <doc>
    This method tests the peer's capability to correctly marshal string
    data.
  </doc>
      <chassis name="client" implement="MUST"/>
      <chassis name="server" implement="MUST"/>
      <response name="string-ok"/>
      <field name="string 1" type="shortstr">
    short string test value
    <doc>
      An short string test value.
    </doc>
      </field>
      <field name="string 2" type="longstr">
    long string test value
    <doc>
      A long string test value.
    </doc>
      </field>
      <field name="operation" type="octet">
    operation to test
    <doc>
      The client must execute this operation on the provided string
      test fields and return the result.
    </doc>
        <assert check="enum">
          <value name="add">return concatentation of test strings</value>
          <value name="min">return shortest of test strings</value>
          <value name="max">return longest of test strings</value>
        </assert>
      </field>
    </method>
    <method name="string-ok" synchronous="1" index="21">
  report string test result
  <doc>
    This method reports the result of a String method.
  </doc>
      <chassis name="client" implement="MUST"/>
      <chassis name="server" implement="MUST"/>
      <field name="result" type="longstr">
    result value
    <doc>
      The result of the tested operation.
    </doc>
      </field>
    </method>
    <!-- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -->
    <method name="table" synchronous="1" index="30">
  test field table handling
  <doc>
    This method tests the peer's capability to correctly marshal field
    table data.
  </doc>
      <chassis name="client" implement="MUST"/>
      <chassis name="server" implement="MUST"/>
      <response name="table-ok"/>
      <field name="table" type="table">
    field table of test values
    <doc>
      A field table of test values.
    </doc>
      </field>
      <field name="integer op" type="octet">
    operation to test on integers
    <doc>
      The client must execute this operation on the provided field
      table integer values and return the result.
    </doc>
        <assert check="enum">
          <value name="add">return sum of numeric field values</value>
          <value name="min">return min of numeric field values</value>
          <value name="max">return max of numeric field values</value>
        </assert>
      </field>
      <field name="string op" type="octet">
    operation to test on strings
    <doc>
      The client must execute this operation on the provided field
      table string values and return the result.
    </doc>
        <assert check="enum">
          <value name="add">return concatenation of string field values</value>
          <value name="min">return shortest of string field values</value>
          <value name="max">return longest of string field values</value>
        </assert>
      </field>
    </method>
    <method name="table-ok" synchronous="1" index="31">
  report table test result
  <doc>
    This method reports the result of a Table method.
  </doc>
      <chassis name="client" implement="MUST"/>
      <chassis name="server" implement="MUST"/>
      <field name="integer result" type="longlong">
    integer result value
    <doc>
      The result of the tested integer operation.
    </doc>
      </field>
      <field name="string result" type="longstr">
    string result value
    <doc>
      The result of the tested string operation.
    </doc>
      </field>
    </method>
    <!-- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -->
    <method name="content" synchronous="1" content="1" index="40">
  test content handling
  <doc>
    This method tests the peer's capability to correctly marshal content.
  </doc>
      <chassis name="client" implement="MUST"/>
      <chassis name="server" implement="MUST"/>
      <response name="content-ok"/>
    </method>
    <method name="content-ok" synchronous="1" content="1" index="41">
  report content test result
  <doc>
    This method reports the result of a Content method.  It contains the
    content checksum and echoes the original content as provided.
  </doc>
      <chassis name="client" implement="MUST"/>
      <chassis name="server" implement="MUST"/>
      <field name="content checksum" type="long">
    content hash
    <doc>
      The 32-bit checksum of the content, calculated by adding the
      content into a 32-bit accumulator.
    </doc>
      </field>
    </method>
  </class>
</amqp>
