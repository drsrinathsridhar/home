function [ X ] = TriangulateDLT( CameraMatrices, Positions2D )
%TRIANGULATEDLT Triangulates 3D point given 2D image positions and cameras
%   This function uses the DLT algorithm as described in page 312 in the
%   book Multiple View Geometry by Hartley and Zisserman. This function
%   checks for NaN values in the positions and discards them. It is assumed
%   that the correct projection matrices are associated with the positions.
%
% CamreaMatrices is 3x4xn where n is the number of views
% Positions2D is nx2 where n is the same as above. The n should match.

% First check if sizes are same
if (size(CameraMatrices, 3) ~= size(Positions2D, 1))
   fprintf('[ ERROR ]: Size of input arguments do not match. Aborting.\n') 
   return
end
NumViews = size(CameraMatrices, 3); % or size(Positions2D, 1)

% Check for and discard NaN values in Positions2D
NANs = isnan(Positions2D);
NaNIndex = sum(NANs')';
if(size(find(NaNIndex), 1) >= NumViews) % All points are NaN. We cannot estimate
    X = [nan, nan, nan]'; % This is a dummy value
    return
end

% Form matrix A in AX = 0
A = [];
for i = 1:NumViews
    if( NaNIndex(i) < 1 ) % Form matrix only for non-NaN positions
       P = CameraMatrices(:, :, i);
       x = Positions2D(i, :);
       RowX = (x(1) * P(3, :)) -  P(1, :);
       RowY = (x(2) * P(3, :)) -  P(2, :);
       A = [A; RowX; RowY]; 
    end
end

% X is the unit singular vector corresponding to the smallest singular
% value. This is in homogeneous coordinates, so normalize in the end.
[U, S, V] = svd(A);
% Pick the last column of V
Xh = V(:, end);
% Finally normalize and we are done
Xh = Xh/Xh(4);

X = Xh(1:3);


end

