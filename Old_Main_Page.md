<table style="width:10%;">
<colgroup>
<col style="width: 0%" />
<col style="width: 0%" />
<col style="width: 0%" />
<col style="width: 0%" />
<col style="width: 0%" />
<col style="width: 0%" />
<col style="width: 0%" />
<col style="width: 0%" />
<col style="width: 0%" />
<col style="width: 0%" />
<col style="width: 0%" />
<col style="width: 0%" />
<col style="width: 0%" />
<col style="width: 0%" />
<col style="width: 0%" />
<col style="width: 0%" />
<col style="width: 0%" />
<col style="width: 0%" />
<col style="width: 0%" />
<col style="width: 3%" />
<col style="width: 0%" />
<col style="width: 0%" />
<col style="width: 0%" />
<col style="width: 0%" />
<col style="width: 0%" />
<col style="width: 0%" />
<col style="width: 0%" />
<col style="width: 0%" />
<col style="width: 0%" />
<col style="width: 0%" />
<col style="width: 0%" />
</colgroup>
<tbody>
<tr class="odd">
<td><p><strong>Free60</strong> is a project towards porting GNU/Linux, BSD, Darwin and related open-source operating systems to the Microsoft Xbox 360 video game console.</p>
<table>
<tbody>
<tr class="odd">
<td><ul>
<li>3-core <strong>PowerPC</strong>, <strong>3.2</strong> GHz</li>
<li><strong>512 MB</strong> of RAM</li>
<li><strong>ATI</strong> graphics</li>
<li>(optional) <strong>20 GB</strong> hard drive</li>
</ul></td>
<td><ul>
<li><strong>DVD</strong> drive</li>
<li>3x <strong>USB</strong> 2.0</li>
<li>100 MBit <strong>Ethernet</strong></li>
<li><strong>TV/VGA</strong> support</li>
</ul></td>
</tr>
</tbody>
</table>
<h2 id="status">Status</h2>
<p>* '''[[Run_Code</p></td>
<td><p>Run Code]]''': You can run your own code on Xbox 360 systems with kernel versions 4532 and 4548. If you own a box manufactured before 2007, upgrade to one of these versions, but to no later one.</p>
<p>* '''[[Linux_Bootloader</p></td>
<td><p>Linux Bootloader]]''': A preliminary second-stage boot loader exists.</p>
<p>* '''[[Linux_Kernel</p></td>
<td><p>Linux Kernel]]''': Patches for the Linux kernel to support a large part of the Xbox 360 hardware exist. As long as you're waiting for a convenient way to boot, you can set up your cross compiler environment.</p>
<p>* <strong>Linux Distributions</strong>: Several [[LiveCD</p></td>
<td><p>LiveCD]] variants and installation howtos for [[Debian-etch</p></td>
<td><p>Debian-etch]], [[Ubuntu7.04</p></td>
<td><p>Ubuntu7.04]] and [[Ubuntu7.10</p></td>
<td><p>Ubuntu7.10]] are available.</p>
<h2 id="documentation">Documentation</h2>
<p>* '''[[First_Steps</p></td>
<td><p>Try it out now</p></td>
<td><p>]]''': How to test out linux (almost) without altering your system.</p>
<p>* <strong>Hardware:</strong> [[CPU</p></td>
<td><p>CPU]], [[GPU</p></td>
<td><p>GPU]], [[R6T3</p></td>
<td><p>R6T3]]</p>
<p>* <strong>Software:</strong> [[Kernel</p></td>
<td><p>Kernel]], [[Hypervisor</p></td>
<td><p>Hypervisor]]</p>
<p>* <strong>Misc:</strong> [[Videos</p></td>
<td><p>Videos]], [[FAQ</p></td>
<td><p>FAQ]]</p>
<h2 id="communication">Communication</h2>
<p>There are several ways for you to get in touch with the people behind Free60 and for sharing information between users. We are an open project and therefore explicitly invite anybody to contact us and to [[Help</p></td>
<td><p>help]].</p>
<p>* '''[[IRC</p></td>
<td><p>IRC]]'''</p></td>
<td><div style="margin: 0; margin-top: 10px; margin-right: 10px; border: 1px solid #dfdfdf; padding: 0em 1em 1em 1em; background-color: #f0f0f0; align: right">
<p>'''29 Sep 2007: 3D Acceleration work has started: ''' tmbinc has released an initial version of his <a href="http://x226.org/?p=38">'gpu' library</a>. It does not yet follow a standard API (like OpenGL), but allows you to play with the 3D GPU.</p>
<p>'''8 May 2007: Updated LiveCD ready: ''' Stonersmurf mastered the updated [[LiveCD</p></td>
<td><p>LiveCD]] including the latest kernel patches. The <a href="http://downloads.sourceforge.net/free60/gentoo-livecd-xenon-beta-v2.iso">download</a> is 621MB in size. See the <a href="http://sourceforge.net/project/shownotes.php?group_id=139616&amp;release_id=506402">Release Notes</a> for details. Here is the [[Press_Release_2007-05-08</p></td>
<td><p>Press Release]].</p>
<p><strong>1 May 2007: We now have a fix for Samsung users</strong> We will soon release an updated [[LiveCD</p></td>
<td><p>LiveCD]]. If you want to build your own kernel, see [[Linux_Kernel_Development</p></td>
<td><p>Linux Kernel Development]] for patches against linux-2.6.21.</p>
<p><strong>1 Apr 2007: X.org driver and a new LiveCD</strong> No April Fools' Day joke. We have released a preliminary <a href="http://sourceforge.net/project/showfiles.php?group_id=139616&amp;package_id=227107">X.org driver</a> and Cpasjuste has built a new [[LiveCD</p></td>
<td><p>LiveCD]] which makes use of it. Unfortunately, support for Samsung drives and sound drivers are still missing.</p>
<p><strong>30 Mar 2007: Gentoo Minimal LiveCD</strong> Cpasjuste has combined the Kernel patches and latest Xell into a LiveCD. The <a href="http://sourceforge.net/project/showfiles.php?group_id=139616">download</a> is about 90MB in size and since it uses the <em>readcd</em> boot method, you may soon be able to boot it without soldering a serial connection to your Xbox 360 mainboard.</p>
<p><strong>20 Mar 2007: Linux Bootloader available</strong> tmbinc has come up with a [[Linux_Bootloader</p></td>
<td><p>Linux Bootloader]], which handles CPU initialization and loads the [[Linux_Kernel</p></td>
<td><p>Linux Kernel]] either from network or CDROM.</p>
<p><strong>8 Mar 2007: First Linux patchset available</strong> Felix Domke posted a patchset for the [[Linux_Kernel</p></td>
<td><p>Linux 2.6.20 Kernel]] to the Linux-PPC mailing list.</p>
<p><strong>1 Mar 2007: Hypervisor privilege-escalation vulnerability</strong> Some &quot;Anonymous Hacker&quot; published a <a href="http://www.securityfocus.com/archive/1/461489">security advisory</a> that will make it possible to run alternative operating systems on the Xbox 360.</p>
<p><strong>30 Dec 2006: Homebrew mock-up at 23C3</strong> An &quot;Anonymous Hacker&quot; showed a Xbox 360 running unsigned code at 23C3 conference. See more in the [[Videos</p></td>
<td><p>Videos]] section.</p>
<p><strong>7 Mar 2006: CPU Datasheet</strong> More great work from [[User:Speedy22</p></td>
<td><p>Speedy22]], this time he has created a datasheet for the Xbox 360's [[CPU</p></td>
<td><p>CPU]]. If can be found <a href="http://www.dave-bell.co.uk/~speedy22/XBOX360cpu15data.pdf">here</a>.</p>
</div></td>
</tr>
</tbody>
</table>

-----

Microsoft, Xbox, Xbox360 (and probably some more) are registered
trademarks by Microsoft Corp. No affiliation between the Free60 Project
and Microsoft Corp. exists or is implied. All other trademarks and
copyrights are property of their respective owners.

Please note that all information on this website is for informational
purpose only and is provided *AS IS*. Everything you do with this
information is on your own risk.

If you believe anything on this site violates any law or any of your
rights, please contact us so that we can find a quick solution.

*Everything done on this project is for the sole purpose of writing
interoperable software under Sect. 1201 (f) Reverse Engineering
exception of the DMCA.*

[Category:Template
documentation](Category:Template_documentation "wikilink")