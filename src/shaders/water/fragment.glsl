uniform vec3 uDepthColor;
uniform vec3 uSurfaceColor;
uniform float uColorOffset;
uniform float uColorMultiplier;

varying float vElevation;

vec3 AmbientLight(vec3 Lightcolor, float intensity){

    return Lightcolor * intensity;
}

void main()
{   
    //Base color
    float mixStrength = (vElevation + uColorOffset) * uColorMultiplier;
    mixStrength = smoothstep(.0, 1., mixStrength);
    vec3 color = mix(uDepthColor, uSurfaceColor, mixStrength);

    // Directional Light
    color += AmbientLight(vec3(1.0, 0.98, 0.98), .2);

    // Final color
    gl_FragColor = vec4(color, 1.0);
    #include <tonemapping_fragment>
    #include <colorspace_fragment>
}