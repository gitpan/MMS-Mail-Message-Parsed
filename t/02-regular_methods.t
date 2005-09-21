#!perl -T

use Test::More tests => 22;
use MMS::Mail::Message::Parsed;

my $message = new MMS::Mail::Message::Parsed;

is($message->header_datetime("Somedate"),"Somedate");
is($message->header_subject("Subject"),"Subject");
is($message->header_from("From"),"From");
is($message->header_to("To"),"To");
is($message->body_text("Text"),"Text");

is($message->datetime("Somedate"),"Somedate");
is($message->subject("Subject"),"Subject");
is($message->from("From"),"From");
is($message->to("To"),"To");
is($message->text("Text"),"Text");

is($message->header_datetime,"Somedate");
is($message->header_subject,"Subject");
is($message->header_from,"From");
is($message->header_to,"To");
is($message->body_text,"Text");

is($message->datetime,"Somedate");
is($message->subject,"Subject");
is($message->from,"From");
is($message->to,"To");
is($message->text,"Text");

is_deeply($message->retrieve_attachments,[]);

is($message->phone_number("00000000000"),"00000000000");

