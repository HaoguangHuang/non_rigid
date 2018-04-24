% output a matrix whose horizontal axis representing frame order while vertical axis representing 
%   position/rotation/translation of nodes.
function node_pos_rot_tras
    addpath(genpath('/home/hhg/Documents/matlab_thirdparty_lib'));
    dateTime = '20180409_1036';
    nodeGraph = load(sprintf('./output/result/nodeGraph_1_50_%s.mat',dateTime));
    nodeGraph = nodeGraph.nodeGraph;
    start_idx = 1; end_idx = 50;
    N = end_idx - start_idx + 1;
    max_node_num = size(nodeGraph{end_idx,2}{4}{2},1);
    output_array_pos = zeros(3*max_node_num, N);
    output_array_rot = zeros(3*max_node_num, N);
    output_array_trs = zeros(3*max_node_num, N);
    
    %vertical axis:pos   1-50
    %  column i:the rotation/translation from i_th to (i+1)_th frame   1-50
    for i = start_idx:end_idx
        for n = 1:size(nodeGraph{i,2}{4}{2},1)
            output_array_pos(3*n-2,i) = nodeGraph{i,2}{4}{2}(n,1); %x
            output_array_pos(3*n-1,i) = nodeGraph{i,2}{4}{2}(n,2); %y
            output_array_pos(3*n,i) = nodeGraph{i,2}{4}{2}(n,3);   %z
            
            T = nodeGraph{i,2}{4}{1}{n,1}.T';
            R = T(1:3,1:3); t = T(1:3,4);
            r = rodrigues(R);
            output_array_rot(3*n-2,i) = r(1); %r1
            output_array_rot(3*n-1,i) = r(2); %r2
            output_array_rot(3*n,i) = r(3);   %r3
            output_array_trs(3*n-2,i) = t(1); %t1
            output_array_trs(3*n-1,i) = t(2); %t2
            output_array_trs(3*n,i) = t(3);   %t3 
        end
    end
    
end