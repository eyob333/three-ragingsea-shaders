uniform vec3 uDepthColor;
uniform vec3 uSurfaceColor;
uniform float uColorOffset;
uniform float uColorMultiplier;

varying float vElevation;

vec3 AmbientLight(vec3 lightcolor, float intensity){

    return lightcolor * intensity;
}

vec3 DirectionalLight( 
    vec3 lightColor, 
    float intensity,
    vec3 normal,
    vec3 position,
    vec3 viewDirection,
    float specularPow
    ){

        vec3 lightDirection = normalize(position);
        vec3 lightReflection = reflect( -lightDirection, normal);

        //shading
        float shading = dot(normal, lightDirection);
        shading = max(.0, shading);

        //specular
        float specular = -dot(lightReflection, viewDirection)
        specular = max( .0, specular);
        specular = pow(specular, specularPow);
        return lightColor * intensity * shading + lightColor * intensity * specular;
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