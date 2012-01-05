#!/bin/bash

#
# Copyright (c) 2012 sutaburosu <steve@st4vs.net>
#
# Permission to use, copy, modify, and distribute this software for any
# purpose with or without fee is hereby granted, provided that the above
# copyright notice and this permission notice appear in all copies.
#
# THE SOFTWARE IS PROVIDED "AS IS" AND THE AUTHOR DISCLAIMS ALL WARRANTIES
# WITH REGARD TO THIS SOFTWARE INCLUDING ALL IMPLIED WARRANTIES OF
# MERCHANTABILITY AND FITNESS. IN NO EVENT SHALL THE AUTHOR BE LIABLE FOR
# ANY SPECIAL, DIRECT, INDIRECT, OR CONSEQUENTIAL DAMAGES OR ANY DAMAGES
# WHATSOEVER RESULTING FROM LOSS OF USE, DATA OR PROFITS, WHETHER IN AN
# ACTION OF CONTRACT, NEGLIGENCE OR OTHER TORTIOUS ACTION, ARISING OUT OF
# OR IN CONNECTION WITH THE USE OR PERFORMANCE OF THIS SOFTWARE.
#

# Show full parser debug output even successfully matched
#FULLDEBUG=1

# Ensure object is up-to-date. You must: ./configure --with-firewall=null
make 1>/dev/null || exit 1

# Make a backup of stdin,  and pipe the test cases into ourselves
exec 3<&0
exec 0<<-"@___EndOfHereDocument___@"
Aug 8 14:31:33 hostname asterisk[1617]: NOTICE[1687]: chan_sip.c:15642 in handle_request_register: Registration from '"154"<sip:154@hostname>' failed for '@BADIP@' - No matching peer found
[2011-12-20 13:15:13]  NOTICE[1687]: chan_sip.c:15642 in handle_request_register: Registration from '"154"<sip:154@hostname>' failed for '@BADIP@' - No matching peer found
[2011-12-20 13:15:13] NOTICE[2016] chan_sip.c: Registration from '"3387"<sip:3387@1-2-3-4-adsl-cust.example.isp.net>' failed for '@BADIP@' - No matching peer found
[2011-12-28 03:07:15] NOTICE[22532] chan_sip.c: Registration from '1234567890 <sip:1234567890@www.example.com>' failed for '@BADIP@' - Device does not match ACL
[2011-11-04 18:30:40.123] NOTICE[32257]: chan_sip.c:23417 in handle_request_register: Registration from '"Poontang"<sip:poontang@1.2.3.4>' failed for '@BADIP@:65535' - Wrong password
[2011-11-04 18:30:40] NOTICE[32257]: chan_sip.c:23417 in handle_request_register: Registration from '"Poontang"<sip:poontang@1.2.3.4>' failed for '@BADIP@:65535' - Wrong password
[2011-12-12 12:21:09] NOTICE[30837] chan_sip.c:23417 in handle_request_register: Registration from '<sip:1234567890@www.example.com>' failed for '@BADIP@:5060' - Wrong password
[2011-12-12 12:21:09] NOTICE[30837] chan_sip.c: Registration from '<sip:1234567890@www.example.com>' failed for '@BADIP@:5060' - Wrong password
[2011-12-12 12:21:09] NOTICE[30837] chan_sip.c: Registration from '<sip:1234567890@www.example.com>' failed for '@BADIP@:01234' - Wrong password
[2011-12-27 16:09:45] NOTICE[22174] chan_sip.c: Registration from '<sip:1234567890@1.2.3.4>' failed for '@BADIP@' - Peer is not supposed to register
[2011-12-28 12:06:03] NOTICE[22532] chan_sip.c: Registration from '1 <sip:1234567890@www.example.com:5060>' failed for '@BADIP@' - Device does not match ACL
[2011-12-12 12:21:09] NOTICE[30837] chan_sip.c: Registration from '<sip:1234567890@www.example.com>' failed for 'badman.st4vs.net:01234' - Wrong password
[2011-04-12 14:37:29] NOTICE[17256] manager.c: @BADIP@ failed to authenticate as 'admin'
[Apr 12 14:37:29] NOTICE[17256]: manager.c:12343 in some_function_or_other: @BADIP@:9876 failed to authenticate as 'admin'
[Jul 13 19:12:14] NOTICE[2970] chan_sip.c: Registration from '"baduser" <sip:baduser@asterisk.example.com>' failed for '@BADIP@:61140' - No matching peer found
[2011-07-13 19:12:14] NOTICE[2970] chan_sip.c: Registration from '"baduser" <sip:baduser@asterisk.example.com>' failed for '@BADIP@:61140' - Username/auth name mismatch
[2011-07-13 19:12:14] NOTICE[2970] chan_sip.c: Registration from '"baduser" <sip:baduser@asterisk.example.com>' failed for '@BADIP@:61140' - Device does not match ACL
[2011-07-13 19:12:14] NOTICE[2970] chan_sip.c: Registration from '"baduser" <sip:baduser@asterisk.example.com>' failed for '@BADIP@:61140' - Peer is not supposed to register
[2011-07-13 19:12:14] NOTICE[2970] chan_sip.c: Registration from '"baduser" <sip:baduser@asterisk.example.com>' failed for '@BADIP@:61140' - ACL error (permit/deny)
[2011-07-13 19:12:14] NOTICE[2970] chan_sip.c: Registration from '"baduser" <sip:baduser@asterisk.example.com>' failed for '@BADIP@:61140' - Not a local domain
[2011-07-13 19:12:14] NOTICE[2970] chan_sip.c: Registration from '"baduser" <sip:baduser@asterisk.example.com>' failed for '@BADIP@:61140' - some future message
[Jul 16 14:34:44] NOTICE[1823] chan_sip.c: Sending fake auth rejection for device "roderickm" <sip:girstwce@192.168.1.104>;tag=aQF8ZHDlcTtoyERbjFkKOnoQHkisuEg9 (@BADIP@:44752)
[Jun 6 18:20:34]NOTICE[3511]: chan_sip.c:12343 in some_function_or_other: No registration for peer '1001' (from @BADIP@)
[Jun 6 18:20:34]NOTICE[3511]: : :No registration for peer '1001' (from @BADIP@)
[2011-07-13 19:12:14] NOTICE[2970] chan_sip.c: Host @BADIP@:1234 failed MD5 authentication for '"baduser" <sip:baduser@asterisk.example.com>'
Sep 30 19:59:03 hostname asterisk[30888]: NOTICE[30924]: chan_sip.c:18390 in handle_request_register: Registration from '"123"<sip:123@phone.example.net>' failed for '@BADIP@' - Username/auth name mismatch 
@___EndOfHereDocument___@

tests=0
fails=0
# For each test case
while read -r line
do
    # Substitute a unique IP for the @BADIP@ marker
    line=${line/@BADIP@/192.168.66.$tests}
    tests=$((tests + 1))

    # Print a summary of which host violated the rules...
    echo "${line}" | SSHGUARD_DEBUG=1 src/sshguard 2>&1 | grep Matched
    failed=$?

    # ...or if the attack was not detected show the debug output
    if [ $failed$FULLDEBUG -gt 0 ]; then
        if [ $failed -gt 0 ]; then
            fails=$((fails + 1))
            echo -e "\n\nNo attack signatures triggered for this test case:\n$line\n"
        fi
        echo "$line" | SSHGUARD_DEBUG=1 src/sshguard 2>&1
        echo -e "\n\n"
    fi
done

# Restore stdin and close its backup
exec 0<&3
exec 3<&-

if [ $fails -gt 0 ]; then
    echo "Failed $fails of $tests tests"
    exit 1
fi

echo "Passed all $tests tests"
exit 0
