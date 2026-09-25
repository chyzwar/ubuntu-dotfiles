/*global getApiVersion, panelIds, panelById, Panel, gridUnit, print */
/* A GNOME-like Plasma 6 layout: one slim top bar and no dock. See the
   ./dotfiles kde section of README.md for why there is no dock.

   Applied by install/kde-install.bash through
   qdbus6 org.kde.plasmashell /PlasmaShell org.kde.PlasmaShell.evaluateScript
   Anything thrown here surfaces as a D-Bus error, which that script checks. */

// recommended at the top of any layout script, it pins the scripting API
const plasma_obj = getApiVersion( 1 );

// pinned next to the menu; Quick Launch shows no windows, so this stays a
// row of launchers and not a dock
const launcher_list = [
  'org.kde.dolphin.desktop',
  'org.kde.konsole.desktop',
  'google-chrome.desktop',
  'code.desktop'
];

// An expanding spacer is the only way to centre one widget in a Plasma panel
// and push another out to the far end
function addSpacerFn ( arg_panel_obj ) {
  const spacer_obj = arg_panel_obj.addWidget( 'org.kde.plasma.panelspacer' );
  spacer_obj.currentConfigGroup = [ 'General' ];
  spacer_obj.writeConfig( 'expanding', true );
}

// Snapshot the panels that exist now. Building before tearing down matters:
// evaluateScript is not transactional, and a throw partway through a
// teardown-first script would leave the desktop with no panel at all.
const old_id_list = Array.prototype.slice.call( panelIds );

// menu and launchers at the left, clock centred, status area at the right
const bar_obj = new Panel;
bar_obj.location = 'top';
bar_obj.floating = 0;
bar_obj.height   = Math.round( gridUnit * 1.8 );

const kickoff_obj = bar_obj.addWidget( 'org.kde.plasma.kickoff' );
kickoff_obj.currentConfigGroup = [ 'General' ];
kickoff_obj.writeConfig( 'icon', 'start-here-kubuntu' );
kickoff_obj.writeConfig( 'showAppsByName', true );

// Quick Launch keeps each launcher as a file URL to its desktop file
const launch_obj = bar_obj.addWidget( 'org.kde.plasma.quicklaunch' );
launch_obj.currentConfigGroup = [ 'General' ];
launch_obj.writeConfig( 'launcherUrls', launcher_list.map( function ( arg_id ) {
  return 'file:///usr/share/applications/' + arg_id;
} ) );

addSpacerFn( bar_obj );

const clock_obj = bar_obj.addWidget( 'org.kde.plasma.digitalclock' );
clock_obj.currentConfigGroup = [ 'Appearance' ];
clock_obj.writeConfig( 'showDate', true );
clock_obj.writeConfig( 'showSeconds', false );

addSpacerFn( bar_obj );

bar_obj.addWidget( 'org.kde.plasma.systemtray' );

for ( let idx = 0; idx < old_id_list.length; idx++ ) {
  const old_obj = panelById( old_id_list[ idx ] );
  if ( old_obj ) { old_obj.remove(); }
}

print( bar_obj.widgets().length + ' widgets in ' + panelIds.length + ' panel' );
