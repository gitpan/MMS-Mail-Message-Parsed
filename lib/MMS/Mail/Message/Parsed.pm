package MMS::Mail::Message::Parsed;

use warnings;
use strict;

use base 'MMS::Mail::Message';

=head1 NAME

MMS::Mail::Message::Parsed - A class representing a parsed MMS (or picture) message, that has been parsed by an MMS::Mail::Provider class.

=head1 VERSION

Version 0.02

=cut

our $VERSION = '0.02';

=head1 SYNOPSIS

This class is used by MMS::Mail::Parser to provide a final data storage class after the MMS has been parsed by the MMS::Mail::Provider class.  It inherits from the MMS::Mail::Message class and extends it's methods to allow access to parsed properties.

=head1 METHODS

The MMS::Mail::Message::Parsed class inherits all the methods from it's parent class MMS::Mail::Message.

=head2 Constructor

=over

=item new()

Return a new MMS::Mail::Message::Parsed object.

=back

=head2 Regular Methods

=over

=item add_image MIME::Entity

Adds the supplied MIME::Entity attachment to the image stack for the message.  This method is mainly used by the MMS::Mail::Provider class to add images while parsing.

=item add_video MIME::Entity

Adds the supplied MIME::Entity attachment to the video stack for the message.  This method is mainly used by the MMS::Mail::Provider class to add videos while parsing.

=item images

Returns an array reference to an array of images from the message.

=item videos

Returns an array reference to an array of videos from the message.

=item datetime STRING

Returns the time and date the MMS was sent when invoked with no supplied parameter.  When supplied with a parameter it sets the object property to the supplied parameter.  This returns the header_datetime property if a datetime property has not been explicitly set.

=item from STRING

Returns the sending email address the MMS was sent from when invoked with no supplied parameter.  When supplied with a parameter it sets the object property to the supplied parameter.  This returns the header_from property if a from property has not been explicitly set.

=item to STRING

Returns the recieving email address the MMS was sent to when invoked with no supplied parameter.  When supplied with a parameter it sets the object property to the supplied parameter.  This returns the header_to property if a to property has not been explicitly set.

=item subject STRING

Returns the MMS subject when invoked with no supplied parameter.  When supplied with a parameter it sets the object property to the supplied parameter.  This returns the header_subject property if a subject property has not been explicitly set.

=item text STRING

Returns the MMS body text when invoked with no supplied parameter.  When supplied with a parameter it sets the object property to the supplied parameter.  This returns the body_text property if a text property has not been explicitly set.

=item phone_number STRING

Returns the MMS mobile number the message was sent from when invoked with no supplied parameter.  When supplied with a parameter it sets the object property to the supplied parameter.  This property is not set by the Provider class but it set by it's subclasses.

=item retrieve_attachments STRING

Expects a mime-type to be passed as an argument and a regular expression match using the supplied string is applied to each attachment in the attachment stack of the message object and a reference to an array of objects where the mime-type matches the supplied string is returned.  In the event no attachment was matched to the supplied mime-type an undef value is returned.

=back

=head1 AUTHOR

Rob Lee, C<< <robl@robl.co.uk> >>

=head1 BUGS

Please report any bugs or feature requests to
C<bug-mms-mail-message-parsed@rt.cpan.org>, or through the web interface at
L<http://rt.cpan.org/NoAuth/ReportBug.html?Queue=MMS-Mail-Message-Parsed>.
I will be notified, and then you'll automatically be notified of progress on
your bug as I make changes.

=head1 NOTES

To quote the perl artistic license ('perldoc perlartistic') :

10. THIS PACKAGE IS PROVIDED "AS IS" AND WITHOUT ANY EXPRESS OR IMPLIED
    WARRANTIES, INCLUDING, WITHOUT LIMITATION, THE IMPLIED WARRANTIES
    OF MERCHANTIBILITY AND FITNESS FOR A PARTICULAR PURPOSE.

=head1 ACKNOWLEDGEMENTS

As per usual this module is sprinkled with a little Deb magic.

=head1 COPYRIGHT & LICENSE

Copyright 2005 Rob Lee, all rights reserved.

This program is free software; you can redistribute it and/or modify it
under the same terms as Perl itself.

=head1 SEE ALSO

L<MMS::Mail::Message>, L<MMS::Mail::Message::Parsed>, L<MMS::Mail::Provider>, L<MMS::Mail::Provider>

=cut

sub new {

  my $class = shift;
  my $message = shift;
  my $self  = $class->SUPER::new();

  bless ($self, $class);

  if (defined($message)) {
    $self->SUPER::_clone_data($message);
  }

  $self->{images} = [];
  $self->{videos} = [];

  return $self;
}

sub subject {

  my $self = shift;
  my $subject = shift;

  unless (defined $subject) {
    if (exists($self->{subject})) {
      return $self->{subject};
    } elsif (defined $self->header_subject) {
      return $self->header_subject;
    } else {
      return undef;
    }
  }
  $self->{subject} = $subject;
}

sub to {

  my $self = shift;
  my $to = shift;

  unless (defined $to) {
    if (exists($self->{to})) {
      return $self->{to};
    } elsif (defined $self->header_to) {
      return $self->header_to;
    } else {
      return undef;
    }
  }
  $self->{to} = $to;
}

sub from {

  my $self = shift;
  my $from = shift;

  unless (defined $from) {
    if (exists($self->{from})) {
      return $self->{from};
    } elsif (defined $self->header_from) {
      return $self->header_from;
    } else {
      return undef;
    }
  }
  $self->{from} = $from;
}

sub datetime {

  my $self = shift;
  my $datetime = shift;

  unless (defined $datetime) {
    if (exists($self->{datetime})) {
      return $self->{datetime};
    } elsif (defined $self->header_datetime) {
      return $self->header_datetime;
    } else {
      return undef;
    }
  }
  $self->{datetime} = $datetime;
}

sub text {

  my $self = shift;
  my $text = shift;

  unless (defined $text) {
    if (exists($self->{text})) {
      return $self->{text};
    } elsif (defined $self->body_text) {
      return $self->body_text;
    } else {
      return undef;
    }
  }
  $self->{text} = $text;
}

sub images {

  my $self = shift;
  my $images = shift;

  unless (defined $images) {
    if (exists($self->{images})) {
      return $self->{images};
    } else {
      return undef;
    }
  }
  $self->{images}=$images;
  
}

sub videos {

  my $self = shift;
  my $videos = shift;

  unless (defined $videos) {
    if (exists($self->{videos})) {
      return $self->{videos};
    } else {
      return undef;
    }
  }
  $self->{videos}=$videos;

}

sub add_image {

  my $self = shift;
  my $image = shift;

  unless (defined($image)) {
    return 0;
  }

  push @{$self->{images}}, $image;

  return 1;

}

sub add_video {

  my $self = shift;
  my $video = shift;

  unless(defined $video) {
    return 0;
  }

  push @{$self->{videos}}, $video;

  return 1;

}

sub retrieve_attachments {

  my $self = shift;
  my $type = shift;

  unless (defined $type) {
    return [];
  }
  
  my @mimeattachments;
  foreach my $attachment (@{$self->attachments}) {
    if ($attachment->mime_type =~ /$type/) {
      push @mimeattachments, $attachment;
    }
  }

  if (@mimeattachments>0) {
    return \@mimeattachments;
  } else {
    return [];
  } 

}

sub phone_number {

  my $self = shift;

  if (@_) { $self->{phone_number} = shift }
  return $self->{phone_number};

}



1; # End of MMS::Mail::Message::Parsed
