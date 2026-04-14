function out = cor_intpol(cr)
%COR_INTPOL Fill missing zeroed slices in cortical representation.
%
% The original thesis code referenced a helper called cor_intpol that was
% not present in the provided source archive. This implementation performs
% linear interpolation along the rate/channel dimension for each time frame,
% scale, and frequency bin whenever one or more all-zero rate slices exist.

out = cr;
[s, r, t, f] = size(cr);
for ti = 1:t
    for si = 1:s
        for fi = 1:f
            y = squeeze(cr(si,:,ti,fi));
            nz = find(abs(y) > 0);
            if isempty(nz)
                continue;
            elseif numel(nz) == 1
                y(:) = y(nz);
            elseif numel(nz) < r
                x = 1:r;
                y = interp1(nz, y(nz), x, 'linear', 'extrap');
            end
            out(si,:,ti,fi) = y;
        end
    end
end
end
