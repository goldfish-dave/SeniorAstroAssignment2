# csv files containing star data is contained in this directory
starDataDirectory = "../star-data/";

# the specific files have the following names
table2 = "high-mass-table2.csv";
table11 = "intermediate-mass-table11.csv";
table18 = "low-mass-table18.csv";

# Load the high, mid and low mass files
highmass = load (strcat(starDataDirectory,table2 ));
midmass  = load (strcat(starDataDirectory,table11));
lowmass  = load (strcat(starDataDirectory,table18));

# read the temperature, luminosity and age for the high, mid and low mass star
function [t,l,a] = getTempLumAge (doormat)
    #[t,l,a] = [doormat(:,5)', doormat(:,4)', doormat(:,2)'];
    t = doormat(:,5);
    l = doormat(:,4);
    a = doormat(:,2);
endfunction

[hightemp, highlum, highage] = getTempLumAge (highmass);
[midtemp, midlum, midage] = getTempLumAge( midmass);
[lowtemp, lowlum, lowage] = getTempLumAge (lowmass);

# 2Dplot the 3 stars on a HR diagram
function plotTempVLum(temps,lums)
    hightemp = temps(:,1); midtemp = temps(:,2); lowtemp = temps(:,3);
    highlum = lums(:,1); midlum = lums(:,2); lowlum = lums(:,3);

    hold off;
    #semilogy(10.^hightemp,10.^highlum);
    semilogy(10.^midtemp ,10.^midlum,"color","green");
    hold all;
    semilogy(10.^lowtemp ,10.^lowlum,"color","red");

    grid on;
    set(gca,"xdir","reverse");
    xlabel "Temperature (K)";
    ylabel "Luminosity (Solar Lum)";
    title "HR Diagram of High, Medium and Low mass stars";
    legend ("High mass (85)", "Medium mass (5)", "Low mass (1.25)","location","southwest")
endfunction

# 3Dplot the 3stars on a HRdiagram with time
function plot3DTempVLumVAge(temps,lums,ages)
    hightemp = temps(:,1); midtemp = temps(:,2); lowtemp = temps(:,3);
    highlum= lums(:,1); midlum= lums(:,2); lowlum= lums(:,3);
    highage= ages(:,1); midage= ages(:,2); lowage= ages(:,3);

    hold off;
    plot3(highage,hightemp,highlum);
    hold all;
    plot3(midage,midtemp,midlum);
    plot3(lowage,lowtemp,lowlum);

    grid on;
    set(gca,"xscale","log");
    xlabel "age";
    ylabel "temp";
    zlabel "lum";
endfunction
    

temps = [ hightemp  midtemp  lowtemp ];
lums =  [ highlum  midlum  lowlum ];
ages =  [ highage  midage  lowage ];

plotTempVLum(temps,lums);
#plot3DTempVLumVAge(temps,lums,ages);
