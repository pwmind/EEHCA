function cos_theta = cos_theta(phi, Beta, collector_azimuth, Sigma)
    arguments
        phi (:,1) double
        Beta (:,1) double
        collector_azimuth (1,1) double
        Sigma (1,1) double
    end
% cos_theta Calculate the cosine of the theta angle
%   phi - Solar azimuth angle (radians)
%   Beta - Solar altitude angle (radians)
%   collector_azimuth - Azimuth angle of the solar collector (radians)
%   Sigma - Angle of the collector relative to horizontal

    cos_theta = cos(Beta) .* cos(phi - collector_azimuth) .* sin(Sigma) + sin(Beta) .* cos(Sigma);

end

