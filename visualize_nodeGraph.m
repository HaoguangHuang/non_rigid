%visualize nodeGraph
function visualize_nodeGraph()
    dateTime = '20180418_2025';
    start_idx = 2;
    pc_address = sprintf('./output/pcd_InfiniTAM/%s',dateTime);
    nodeGraph = load(sprintf('./output/result/nodeGraph_1_50_%s.mat',dateTime));
    nodeGraph = nodeGraph.nodeGraph;
    r = 75; %mm
    MarkerSpecs = {'.','o','x','d'};
    ColorSpecs = {'k','b','g','y'};
    [x,y,z] = sphere(15); 
    for i = 2:50
        pc = pcread(sprintf('%s/fusioned_pc_%d.pcd',pc_address,i));
        pc.Color = repmat(uint8([255,0,0]),pc.Count,1);
        nodes_pos = nodeGraph{i,2}{1,end}{2};
        
        fig = figure(5); hold on;
        for j = 1:size(nodes_pos,1)
            yushu = mod(j,4); shang = floor(j/4);
            plot3(nodes_pos(j,1),nodes_pos(j,2),nodes_pos(j,3),[ColorSpecs{shang+1},MarkerSpecs{yushu+1}],'markersize',15,'DisplayName',int2str(j));
            mesh(x*r+nodes_pos(j,1),...
            y*r+nodes_pos(j,2),...
            z*r+nodes_pos(j,3));
            alpha(0);
        end 
        legend('show');
        pcshow(pc); hold off;
        title(['frame ',int2str(i)]);
        xlabel('x'),ylabel('y'),zlabel('z'); 
        view([-10,-80]); drawnow;
        pause(0.5);
        clf(fig);
    end
end