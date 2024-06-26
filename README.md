## Image Processing Pipeline Architecture

### Block Diagram

![Image Enhancement Algorithm](Images/block_diagram.png)

### Module 1: Image Smoothening

- **Functionality:** This module processes 18 pixels in parallel.
- **Timing Report:** 
  - DataPathDelay = 19.575 
  - LogicDelay = 7.698
  - RoutingDelay = 11.877
- **Utilization Report:** 
  - DynamicPower = 47.566
  - StaticPower = 1.31
  - SignalPower = 11.152
  - LogicPower = 11.878
- **Power Report:** 
  - TotalPower = 48.876
  - Muxes = 26
  - LUT_as_memory = 124
  - LUT_as_logic = 390
  - Slice_LUT = 338
  - LUT1 = 76
  - LUT2 = 50
  - LUT3 = 0

- **Simulation Results** 
![Image Enhancement Algorithm](Images/smoothening.jpg)

### Module 2: Image Sharpening

- **Functionality:** This module processes 9 pixels in parallel.
- **Timing Report:** 
  - DataPathDelay = 10.803
  - LogicDelay = 7.590
  - RoutingDelay = 16.955
- **Utilization Report:** 
  - DynamicPower = 24.798
  - StaticPower = 0.348
  - SignalPower = 6.626
  - LogicPower = 4.709
- **Power Report:** 
  - TotalPower = 21.978
  - Muxes = 662
  - LUT_as_memory = 304
  - LUT_as_logic = 172
  - Slice_LUT = 18
  - LUT1 = 297
  - LUT2 = 0
- **Simulation Results** 
![Image Enhancement Algorithm](Images/sharpening.jpg)

### Module 3: Image Addition

- **Functionality:** This module processes 1 pixel in parallel.
- **Timing Report:** 
  - Slack: inf
  - DataPathDelay = 4.504ns 
  - LogicLevels: 2 
- **Utilization Report:** 
  - Slice LUTs: 8
  - Registers: 11
- **Power Report:** 
  - TotalPower = 0.047
- **Simulation Results** 
![Image Enhancement Algorithm](Images/addition.jpg)

### Module 4: Normalization

- **Functionality:** This module processes 1 pixel in parallel.
- **Timing Report:** 
  - DataPathDelay = 12.313
  - LogicDelay = 5.17
  - RoutingDelay = 7.143
- **Utilization Report:** 
  - DynamicPower = 11.788
  - StaticPower = 0.185
  - SignalPower = 0.663
  - LogicPower = 0.564
- **Power Report:** 
  - TotalPower = 11.973
  - Muxes = 104
  - LUT_as_memory = 7
  - LUT_as_logic = 43
  - Slice_LUT = 27
  - LUT1 = 10
  - LUT2 = 14
  - LUT3 = 16
- **Simulation Results** 
![Image Enhancement Algorithm](Images/Normalization.png)

**Note:** Detailed Synthesis Report are attached in the synthesis folder.

### Design Pipeline

- **Bit Width:** 8 for BRAM
- **Pipeline Functionality:**
  - Initial Smoothening and Sharpening: Stall pipeline until 9 values are obtained.
  - Subsequent Processes: Stall pipeline until 2 values are read.
  - No stall required after the first two processes as only one value is needed.

### Stages of the Pipeline

1. **Stage 1: Smoothening - Part 1**
   - Calculate sum of input pixels.

2. **Stage 2: Smoothening - Part 2**
   - Divide sum by total number of pixels (9 for 3x3 average filter).

3. **Stage 3: Sharpening - Part 1**
   - Perform convolution by multipling parallely.
     
3. **Stage 4: Sharpening - Part 2**
   - Perform accumulation of pixels.

4. **Stage 5: Addition**
   - Add sharpened image to input image.

5. **Stage 6: Normalization - Part 1**
   - Evaluate expression: 255×(Input_channel pixel value−min pixel value).

6. **Stage 7: Normalization - Part 2**
   - Divide product by (max pixel value−min pixel value).

### Implementation Details

- Smoothening: Calculate two pixel values in parallel within a single clock cycle to support subsequent sharpening.
- Sharpening: Single clock cycle operation.
- Addition: Single clock cycle operation.
- Normalization: Implemented with two stages - numerator calculation and division, each taking one clock cycle.

This pipeline architecture optimizes processing efficiency while maintaining synchronization across modules.
