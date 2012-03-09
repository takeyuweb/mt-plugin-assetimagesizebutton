package AssetImageSizeButton::Plugin;
use strict;
use warnings;

sub _cb_ts_asset_options_image {
    my ($cb, $app, $tmpl_ref) = @_;
    
    $$tmpl_ref = <<"TMPL";
<script type="text/javascript">
function setThumbWidth( form, size ) {
    console.log(form);
    var elem = form.getElementsByTagName('input')['thumb_width'];
    elem.value = size;
    var check = form.getElementsByTagName('input')['create_thumbnail'];
    check.checked = true;
    adjustWidthHeight(form, 1);
}
</script>
$$tmpl_ref
TMPL
    1;
}

sub _cb_tp_asset_options_image {
    my ( $cb, $app, $param, $tmpl ) = @_;

    my $plugin = MT->component( 'AssetImageSizeButton' );

    my $large = $plugin->get_config_value( 'large', 'system' ) || 480;
    my $midium = $plugin->get_config_value( 'midium', 'system' ) || 360;
    my $small = $plugin->get_config_value( 'small', 'system' ) || 240;

    my $thumbnail_field = $tmpl->getElementById('create_thumbnail');
    my $html = $thumbnail_field->innerHTML();
    $html = <<"TMPL";
$html
<input type="button" value="@{[ $plugin->translate( 'Large' ) ]}" onclick="setThumbWidth(this.form, @{[ $large ]}); return false;" />
<input type="button" value="@{[ $plugin->translate( 'Midium' ) ]}" onclick="setThumbWidth(this.form, @{[ $midium ]}); return false;" />
<input type="button" value="@{[ $plugin->translate( 'Small' ) ]}" onclick="setThumbWidth(this.form, @{[ $small ]}); return false;" />

TMPL
    $thumbnail_field->innerHTML( $html );
    1;
}

1;
